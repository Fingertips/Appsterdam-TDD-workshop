require 'rubygems'
require 'mac_bacon'

def add(string)
  return 0 if string.empty?
  string.to_i
end

describe "The string calculator method `Add'" do
  it "returns 0 for an empty string" do
    add("").should == 0
  end

  it "returns the given digit if the string consists of just one digit" do
    add("1").should == 1
  end
end
