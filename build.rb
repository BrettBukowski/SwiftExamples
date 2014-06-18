#!/usr/bin/ruby

require 'fileutils'

class HTML
  def self.template(name, path, content)
    <<-HTML
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
        <title>Swift by example: #{name}</title>
        <link rel="stylesheet" href="#{path}site.css"></link>
      </head>
      <body>
        <div id="container">
          <main>
            <h1>Swift by example: #{name}</h1>
            <table>
              <tbody>
                #{content}
              </tbody>
            </table>
          <main>
          <footer>
            by <a href="https://twitter.com/BrettBukowski">@BrettBukowski</a>
            <a href="https://github.com/BrettBukowski/SwiftExamples">source</a>
          </footer>
        </div>
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
    @code = '&nbsp;' if @code.strip.empty?
    "<tr><td class='docs'>#{@explanation}</td><td class='code'><pre><code class='language-swift'>#{@code}</code></pre></td></tr>"
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
      "<li><a href='#{@docs_path}/#{step[:slug]}/index.html'>#{step[:title]}</a></li>"
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
