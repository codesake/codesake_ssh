require 'spec_helper'

describe Codesake::SSH::Config do
  describe "has a default configuration" do

    before(:all) do
      @nil_conf = Codesake::SSH::Config.read_conf(nil)
      
    end

    it "available" do
      @nil_conf.should_not be_nil
    end

    it "to test for port 22" do
      vet = [22]
      @nil_conf["config"]["ports_to_scan"].should == vet
    end

    it "has a ports shortcut" do
      vet = [22]
      Codesake::SSH::Config.ports.should == vet
    end
  end


end
