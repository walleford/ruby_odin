# ccwc.rb by jordan
# a ruby version of the linux cli tool wc
# used for printing word, line, and byte
require 'debug'
require 'optparse'

def line_count file
  # function used to print out line count of the passed in file
  counter = 0
  File.foreach(file) do |line|
    counter += 1
  end

  puts "Line count for #{file} is #{counter}"
end

def word_count file
  # function to print out how many words are in a file
  word_counter = 0
  File.foreach(file) do |line|
    word_counter += line.split.length
  end
  puts "Word count for #{file} is #{word_counter}"
end

def byte_size file
  # function to print out how many bytes a file is in size
  puts "Size of #{file} is #{File.size(file)} bytes"
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ruby ccwc.rb [-m/-f]"

    opts.on("-f", "--file FILE", "Specify the input file") do |file|
      options[:file] = file
    end

    opts.on("-m", "--mode MODE", "Specify mode: wc, lc, byte, all") do |mode|
      options[:mode] = mode
    end

    opts.on("-h", "--help", "prints help message") do
      puts opts
      exit
    end
  end.parse!

  begin
    if options[:file].nil?
      raise ArgumentError, "you must specify a file!"
    end

    case options[:mode]
    when "lc"
      line_count(options[:file])
    when "wc"
      word_count(options[:file])
    when "byte"
      byte_size(options[:file])
    when "all"
      line_count(options[:file])
      word_count(options[:file])
      byte_size(options[:file])
    else
      puts "you didn't provide a proper argument: wc, lc, byte, all"
      exit
    end

  rescue ArgumentError => e
    puts "Error: #{e.message}"
  rescue Errno::ENOENT
    puts "file not found: #{options[:file]}"
  rescue => e
    puts "An unexpected error occured: #{e.message}"
  end
end
