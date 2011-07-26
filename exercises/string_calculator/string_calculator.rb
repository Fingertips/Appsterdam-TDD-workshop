# Original kata from: http://osherove.com/tdd-kata-1
#
# 1. First make sure the MacBacon Ruby gem is installed:
#      $ macgem install mac_bacon-1.3.gem
# 2. Run the test with: $ macbacon string_calculator.rb
#
# If you want to automatically run the test everytime a file is saved, you can
# do so with the Kicker Ruby gem:
#
# 1. Install the dependency:
#      $ macgem install rb-fsevent-0.4.1.gem
# 2. Then install the actual Kicker gem:
#      $ macgem install kicker-2.3.1.gem
# 3. Finally, run the test like so:
#      $ kicker -c -e 'macbacon string_calculator.rb'

require 'rubygems'
require 'mac_bacon'


# Compile string_calculator.m as a bundle loadable by MacRuby and `require' it (loads the bundle).
implementation = File.expand_path("../string_calculator.m", __FILE__)
bundle = File.expand_path("../string_calculator.bundle", __FILE__)
puts `clang -fobjc-gc -framework Foundation -bundle -o '#{bundle}' '#{implementation}'`
require bundle

describe "The -[StringCalculator add:] method" do
  before do
    @calculator = StringCalculator.alloc.init
  end

  it "returns 0 for an empty string" do
    @calculator.add("").should == 0
  end

  # The rest's up to you, buddy :)

end
