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
  end

  it "returns the message" do
  end
end

describe "WindowController" do
  before do
    @controller = WindowController.new
    @controller.showWindow(self)
    # Replace the host with our local address
    @controller.searchURLString = @controller.searchURLString.sub("search.twitter.com", "127.0.0.1:9292")
  end

  it "enables the search button if the textfield contains text" do
  end

  # Helper method that sends the action message to the button's target and
  # passes the button as the argument, which is common with target-action
  # messages.
  def performSearchButtonAction
    target = @controller.searchButton.target
    action = @controller.searchButton.action
    target.send(action, @controller.searchButton)
  end

  it "performs a search on the remote webservice" do
  end

  it "shows the search results in the tableview" do
  end
end
