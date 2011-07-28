# Compile Application.m as a bundle loadable by MacRuby and `require' it (loads the bundle).
root = File.expand_path("../../", __FILE__)
implementation = File.join(root, "TweetyGonzalez", "Application.m")
bundle = File.join(root, "spec", "Application.bundle")
puts `clang -fobjc-gc -framework Cocoa -bundle -o '#{bundle}' '#{implementation}'`
require bundle


framework 'Cocoa'


describe "Tweet" do
  it "performs a search on the remote webservice" do
  end

  it "returns the author's name" do
  end

  it "returns the message" do
  end
end

describe "WindowController" do
  before do
    @controller = WindowController.new
    @controller.showWindow(self)
  end

  it "enables the search button if the textfield contains text" do
    @controller.searchButton.isEnabled.should == false

    @controller.searchField.stringValue = "omg"
    @controller.controlTextDidChange(nil)
    @controller.searchButton.isEnabled.should == true

    @controller.searchField.stringValue = ""
    @controller.controlTextDidChange(nil)
    @controller.searchButton.isEnabled.should == false
  end

  it "performs a search on the remote webservice" do
    # stub expect
  end

  it "shows the search results in the tableview" do
  end
end
