ROOT = File.expand_path("../../", __FILE__)

framework 'Cocoa'

# Compile Application.m as a bundle loadable by MacRuby and `require' it (loads the bundle).
implementation = File.join(ROOT, "TweetyGonzalez", "Application.m")
bundle = File.join(ROOT, "spec", "Application.bundle")
puts `clang -fobjc-gc -framework Cocoa -bundle -o '#{bundle}' '#{implementation}'`
require bundle


def search_fixture(name)
  File.join(ROOT, "spec", "fixtures", "#{name}.xml")
end


SIMPLE_TWEET_XML = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<feed>
  <entry>
    <title>Andale andale, arriba arriba, epa epa epa, yeehaw!</title>
    <author>
      <name>speedy (Speedy Gonzales)</name>
    </author>
  </entry>
</feed>
XML

describe "Tweet" do
  it "returns a list of Tweet instances" do
    Tweet.tweetsWithXMLString(SIMPLE_TWEET_XML).size.should == 1
    Tweet.tweetsWithXMLString(File.read(search_fixture("tweety"))).size.should == 15
  end

  before do
    @tweet = Tweet.tweetsWithXMLString(SIMPLE_TWEET_XML).first
  end

  it "returns the author's name" do
    @tweet.author.should == "speedy (Speedy Gonzales)"
  end

  it "returns the message" do
    @tweet.message.should == "Andale andale, arriba arriba, epa epa epa, yeehaw!"
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
