# encoding: utf-8

require 'spec_helper'

describe DataKit::Converters::Integer do
  it "should match values" do
    ["100.0", "-100.5", "-1,000.00", "5.6E11", "$1,000.21"].each do |number|
      reformatted = DataKit::Converters::Number.reformat(number)
      DataKit::Converters::Number.match?(reformatted).should == true
    end
  end

  it "should convert value it can match" do
    {
      "100.0" => 100.0, "-100.5" => -100.5,
      "-1,000.00" => -1000.00, "5.6E11" => 5.6E11, "$1,000.21" => 1000.21
    }.each do |testcase, result|
      reformatted = DataKit::Converters::Number.reformat(testcase)
      DataKit::Converters::Number.convert(reformatted).should == result
    end
  end

  it "should reformat strings with unknown encodings" do
    str = "9350 Waxie WayÊSuite"
    DataKit::Converters::Number.reformat(str).should == str
  end
end