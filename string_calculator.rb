require 'rubygems'
require 'mac_bacon'

def add(string)
  return 0 if string.empty?
  result = 0
  string.split(/,|\n/).each do |s|
    raise ArgumentError, "no empty values allowed" if s.empty?
    result = result + s.to_i
  end
  result
end

describe "The string calculator method `Add'" do
  it "returns 0 for an empty string" do
    add("").should == 0
  end

  it "returns the given number if the string consists of just one number" do
    add("1").should == 1
  end

  it "returns the sum of two numbers delimited by a comma" do
    add("1,2").should == 3
  end

  it "takes numbers consisting of two or more digits" do
    add("21,21").should == 42
  end

  it "takes an unlimited amount of numbers" do
    add("1,20,2,19").should == 42
  end

  it "allows new lines between the numbers" do
    add("1\n2,3").should == 6
  end

  it "does not allow empty values" do
    lambda { add("1,\n2") }.should.raise ArgumentError
  end

  it "checks the first line of the string for a custom delimiter" do
    add("//;\n1;2").should == 3
  end
end
