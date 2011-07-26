# http://osherove.com/tdd-kata-1/

require 'rubygems'
require 'mac_bacon'

# Compile string_calculator.m as a bundle loadable by MacRuby and `require' it (loads the bundle).
implementation = File.expand_path("../string_calculator.m", __FILE__)
bundle = File.expand_path("../string_calculator.bundle", __FILE__)
puts `clang -fobjc-gc -framework Foundation -bundle -o '#{bundle}' '#{implementation}'`
require bundle

#def add(string)
  #delimiter = ","
  #if string[0,2] == "//"
    #if string[3,1] != "\n"
      #raise ArgumentError, "the custom delimiter has to be on the first line, numbers on the next"
    #end
    #delimiter = string[2,1]
    #string = string[4..-1]
  #end

  #numbers = string.split(/#{delimiter}|\n/)
  #raise ArgumentError, "no empty values allowed" if numbers.any? { |s| s.empty? }
  #numbers = numbers.map { |s| s.to_i }
  #negatives = numbers.select { |i| i < 0 }
  #raise ArgumentError, "no negative numbers allowed: #{negatives.join(", ")}" unless negatives.empty?
  #numbers.inject(0) { |sum, i| sum + i }
#end

describe "The string calculator method `Add'" do
  before do
    @calculator = StringCalculator.new
  end

  it "returns 0 for an empty string" do
    @calculator.add("").should == 0
  end

  it "returns the given number if the string consists of just one number" do
    @calculator.add("1").should == 1
  end

  it "returns the sum of two numbers delimited by a comma" do
    @calculator.add("1,2").should == 3
  end

  it "takes numbers consisting of two or more digits" do
    @calculator.add("21,21").should == 42
  end

  it "takes an unlimited amount of numbers" do
    @calculator.add("1,20,2,19").should == 42
  end

  it "allows new lines between the numbers" do
    @calculator.add("1\n2,3").should == 6
  end

  it "does not allow empty values" do
    lambda { @calculator.add("1,\n2") }.should.raise(ArgumentError)
  end

  it "checks the first line of the string for a custom delimiter" do
    @calculator.add("//;\n1;2").should == 3
  end

  it "does not allow a custom delimiter on the same line as the numbers" do
    exception = lambda { @calculator.add("//;1;2") }.should.raise(ArgumentError)
    exception.message.should == "the custom delimiter has to be on the first line, numbers on the next"
  end

  it "does not allow negative values and tells the user which values those were" do
    exception = lambda { @calculator.add("-3,5,-7") }.should.raise(ArgumentError)
    exception.message.should.include "-3, -7"
  end
end
