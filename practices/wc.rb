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

def line_count_stdin input
  # function used to print out line count of the passed in file
  counter = 0
  input.each_line do |line|
    counter += 1
  end

  puts "Line count of input is #{counter}"
end

def word_count_stdin input
  # function to print out how many words are in a file
  word_counter = 0
  input.each_line do |line|
    word_counter += line.chomp.split.length
  end
  puts "Word count of input is #{word_counter}"
end

def byte_size_stdin input
  # function to print out how many bytes a file is in size
  total_bytes = 0
  input.each_line do |line|
    total_bytes += line.bytesize
  end
  puts "Size of input is #{total_bytes} bytes"
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ruby ccwc.rb [-m/-f]"

    opts.on("-f", "--file FILE", "Specify the input file") do |file|
      options[:file] = file
    end

    opts.on("-m", "--mode MODE", "Specify mode: wc, lc, byte") do |mode|
      options[:mode] = mode
    end

    opts.on("-h", "--help", "prints help message") do
      puts opts
      exit
    end
  end.parse!

  begin
    if !$stdin.tty?
      all_input = $stdin.read
      case options[:mode]
      when "lc"
        line_count_stdin(all_input)
      when "wc"
        word_count_stdin(all_input)
      when "byte"
        byte_size_stdin(all_input)
      else
        line_count_stdin(all_input)
        word_count_stdin(all_input)
        byte_size_stdin(all_input)
      end
    else
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
      else
        line_count(options[:file])
        word_count(options[:file])
        byte_size(options[:file])
      end
    end

  rescue ArgumentError => e
    puts "Error: #{e.message}"
  rescue Errno::ENOENT
    puts "file not found: #{options[:file]}"
  rescue => e
    puts "An unexpected error occured: #{e.message}"
  end
end
