require "../spec_helper"

module Calcium
  describe "#format" do
    it "leaves simple numbers alone" do
      format(5).should eq("5")
    end

    it "handles negatives" do
      format(-1).should eq("-1")
    end

    it "strips trailing zeros" do
      format(5.0).should eq("5")
    end

    it "includes significant decimals" do
      format(5.5).should eq("5.5")
    end

    it "truncates to 4 decimal places" do
      format(3.33333).should eq("3.3333")
    end

    it "rounds numbers" do
      format(6.66666).should eq("6.6667")
    end
  end
end
