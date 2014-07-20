require 'spec_helper'

module SwModuleActionx
  describe ModuleAction do
    it "should be OK" do
      c = FactoryGirl.build(:sw_module_actionx_module_action)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:sw_module_actionx_module_action, :name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil module desp" do
      c = FactoryGirl.build(:sw_module_actionx_module_action, :resource => nil)
      c.should_not be_valid
    end
    
    it "should reject duplicate name" do
      c0 = FactoryGirl.create(:sw_module_actionx_module_action, :name => 'A name')
      c = FactoryGirl.build(:sw_module_actionx_module_action, :name => 'a name')
      c.should_not be_valid
    end
  end
end
