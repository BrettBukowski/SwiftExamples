#!/usr/bin/ruby

require 'cgi'
require 'fileutils'

class HTML
  def self.template(name, path, content)
    topic = "<span class='topic'>#{name}</span>" unless name.empty?
    <<-HTML
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
        <title>Swift by example - #{name}</title>
        <link href='http://fonts.googleapis.com/css?family=Fira+Sans' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="#{path}site.css"></link>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/prism/0.0.1/prism.min.css"></link>
        <link rel="shortcut icon" href="favicon.ico">
      </head>
      <body>
        <div id="container">
          <h1><a href='#'>Swift by example</a> #{topic}</h1>
          <main>
            <table>
              <tbody>
                #{content}
              </tbody>
            </table>
          </main>
          <footer>
            by <a href="https://twitter.com/BrettBukowski">@BrettBukowski</a>
            <a href="https://github.com/BrettBukowski/SwiftExamples">source</a>
          </footer>
        </div>
        <script async src="#{path}site.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/prism/0.0.1/prism.min.js"></script>
      </body>
    </html>
    HTML
  end
end

class Example
  def initialize
    @code = ''
    @explanation = ''
  end

  def add(line)
    if line.start_with?('//')
      line = line.gsub('//', '')
      line = "<h2>#{line}</h2>" if line.start_with?(" #")
      @explanation += line
    else
      @code += line
    end
  end

  def to_html
    @code = ' ' if @code.strip.empty?
    <<-HTML
    <tr>
      <td class='docs'>
        #{@explanation.gsub(/(`)([a-zA-Z0-9\?]+)(`)/) {"<code>#{$2}</code>"}}
      </td>
      <td class='code'>
        <pre><code class='language-swift'>#{CGI.escapeHTML(@code)}</code></pre>
      </td>
    </tr>
    HTML
  end
end

class ExampleFile
  def initialize(path)
    @name = File.basename(path, '.swift')
    @examples = [Example.new]
  end

  def new_example
    @examples << Example.new
  end

  def feed(line)
    new_example if line.start_with? '//'
    @examples.last.add(line)
  end

  def write!(dir)
    path = "#{dir}/#{@name}"
    FileUtils.mkdir(path) unless File.directory?(path)
    File.open("#{path}/index.html", 'w') { |f| f.write(to_html) }
  end

  def to_html
    HTML.template(@name, '../', collate)
  end

  private

  def collate
    @examples.map do |example|
      example.to_html
    end.join("\n")
  end
end

class IndexFile
  def initialize(path)
    @docs_path = path
  end

  def write!
    File.open('index.html', 'w') { |f| f.write(to_html) }
  end

  def to_html
    html = "<ol>" + steps_from_readme.map do |step|
      "<li><a href='#{@docs_path}/#{step[:slug]}'>#{step[:title]}</a></li>"
    end.join("\n") + "</ol>"

    HTML.template('', 'examples/', html)
  end

  def steps_from_readme
    readme = File.open('README.md', 'r')
    steps = []
    readme.each_line do |line|
      step_match = line.match(/^(\d+)\. (.*)$/)

      next if step_match.nil?

      steps << {
        title: step_match[2],
        slug: step_match[2].downcase.gsub(/[\/ ]/, '-'),
      }
    end

    steps
  end
end

class Builder
  def initialize(output_dir)
    @output_dir = output_dir
  end

  def build!(files)
    files.each do |swift_file_path|
      example_file = ExampleFile.new(swift_file_path)
      swift_file = File.open(swift_file_path, 'r')

      swift_file.each_line do |line|
        next if line == ''
        example_file.feed(line)
      end

      example_file.write!(@output_dir)
    end

    IndexFile.new(@output_dir).write!
  end
end

Builder.new('examples').build!(Dir["*.swift"])
