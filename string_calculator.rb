require 'rubygems'
require 'mac_bacon'

describe "The string calculator method `Add'" do
  it "returns 0 for an empty string" do
    add("").should == 0
  end
end
