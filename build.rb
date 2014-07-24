#!/usr/bin/ruby

require 'erb'
require 'cgi'
require 'ostruct'
require 'fileutils'

class HTML < OpenStruct
  @@template = ERB.new(File.read('template.html.erb'))

  def render
    @@template.result(binding)
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
        #{@explanation.gsub(/(`)([a-zA-Z0-9\?@]+)(`)/) {"<code>#{$2}</code>"}}
      </td>
      <td class='code'>
        <pre><code class='language-swift'>#{CGI.escapeHTML(@code)}</code></pre>
      </td>
    </tr>
    HTML
  end
end

class ExampleFile
  attr_accessor :nxt, :prev

  def initialize(path)
    @name = File.basename(path, '.swift')
    @examples = [Example.new]
  end

  def new_example
    @examples << Example.new
  end

  def feed(line)
    return if line == ''
    new_example if line.start_with? '//'
    @examples.last.add(line)
  end

  def write!(dir)
    path = "#{dir}/#{@name}"
    FileUtils.mkdir(path) unless File.directory?(path)
    File.open("#{path}/index.html", 'w') { |f| f.write(to_html) }
  end

  def to_html
    HTML.new({name: @name.gsub('-', ' '), path: '../', content: collate, nxt: nxt, prev: prev}).render
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
    html = "<ol>" + steps.map do |step|
      "<li><a href='#{@docs_path}/#{step[:slug]}'>#{step[:title]}</a></li>"
    end.join("\n") + "</ol>"

    HTML.new({name: '', path: 'examples/', content: html}).render
  end

  def steps
    @steps ||= steps_from_readme
  end

  private

  def steps_from_readme
    readme = File.open('README.md', 'r')
    steps = []
    readme.each_line do |line|
      step_match = line.match(/^(\d+)\. (.*)$/)

      next if step_match.nil?

      slug = step_match[2].downcase.gsub(/[\/ ]/, '-')

      steps << {
        title: step_match[2],
        slug: slug,
        file: "#{slug}.swift",
      }
    end

    [nil, *steps, nil].each_cons(3) do |prev, current, nxt|
      current[:prev] = prev.dup unless prev.nil?
      current[:nxt] = nxt.dup unless nxt.nil?
    end

    steps
  end
end

class Builder
  def initialize(index, output_dir)
    @index = index
    @output_dir = output_dir
  end

  def build!
    @index.steps.each do |step|
      swift_file_path = step[:file]
      example_file = ExampleFile.new(swift_file_path)
      example_file.nxt = step[:nxt]
      example_file.prev = step[:prev]

      File.open(swift_file_path, 'r').each_line do |line|
        example_file.feed(line)
      end

      example_file.write!(@output_dir)
    end
  end
end

index = IndexFile.new('examples')
index.write!
Builder.new(index, 'examples').build!
