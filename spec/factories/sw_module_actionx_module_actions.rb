# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_module_actionx_module_action, :class => 'SwModuleActionx::ModuleAction' do
    module_info_id 1
    last_updated_by_id 1
    name "MyString"
    name_non_tech 'a explaination'
    desp_non_tech "MyString"
    resource "MyString"
    resource_non_tech 'something'
    desp "MyString"
    present_to_customer true
  end
end
