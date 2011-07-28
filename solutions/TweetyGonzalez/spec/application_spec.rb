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
    @controller.searchURLString = "http://127.0.0.1:9292/search.atom?q=%@"
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

  # Send the action message to the button's target and passes the button as
  # the argument, which is common with target-action messages.
  def performSearchButtonAction
    target = @controller.searchButton.target
    action = @controller.searchButton.action
    target.send(action, @controller.searchButton)
  end

  it "performs a search on the remote webservice" do
    @controller.searchField.stringValue = "tweety"
    performSearchButtonAction
    wait 1 do
      @controller.tweets.size.should == 15

      @controller.searchField.stringValue = "NO-RESULTS"
      performSearchButtonAction
      wait 1 do
        @controller.tweets.size.should == 0
      end
    end
  end

  it "shows the search results in the tableview" do
  end
end
