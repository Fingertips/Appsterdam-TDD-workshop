require 'rubygems'
require 'mac_bacon'

def add(string)
  return 0 if string.empty?
  first_number, last_number = string.split(',')
  first_number.to_i + last_number.to_i
end

describe "The string calculator method `Add'" do
  it "returns 0 for an empty string" do
    add("").should == 0
  end

  it "returns the given digit if the string consists of just one digit" do
    add("1").should == 1
  end

  it "returns the sum of two numbers delimited by a comma" do
    add("1,2").should == 3
  end

  it "takes numbers consisting of two or more digits" do
    add("21,21").should == 42
  end
end
