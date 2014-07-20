require 'spec_helper'

describe "LinkTests" do
  describe "GET /sw_module_actionx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @mod_info = FactoryGirl.create(:sw_module_infox_module_info)
      
      user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_module_actionx_module_actions',  :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwModuleActionx::ModuleAction.scoped.order('id DESC')")     
        
      user_access = FactoryGirl.create(:user_access, :action => 'create', :resource =>'sw_module_actionx_module_actions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'update', :resource =>'sw_module_actionx_module_actions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_module_actionx_module_actions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource =>'sw_module_actionx_module_actions', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      qs1 = FactoryGirl.create(:sw_module_actionx_module_action, :last_updated_by_id => @u.id, :module_info_id => @mod_info.id)
        
      visit module_actions_path
      save_and_open_page
      page.should have_content('Actions')
      click_link 'Edit'
      page.should have_content('Edit Action')
      save_and_open_page
      fill_in 'module_action_name', :with => 'a test bom with a tail'
      click_button 'Save'
      visit module_actions_path()
      page.should have_content('a test bom with a tail')
      #with wrong data
      visit module_actions_path
      #save_and_open_page
      page.should have_content('Actions')
      click_link 'Edit'
      fill_in 'module_action_name', :with => 'a new new name'
      fill_in 'module_action_resource', :with => ''
      click_button 'Save'
      visit module_actions_path()
      page.should_not have_content('a new new name')
      
      visit module_actions_path
      click_link qs1.id.to_s
      save_and_open_page
      page.should have_content('Action Info')
      #click_link 'New Log'
      #save_and_open_page
      #page.should have_content('Log')
      
      visit module_actions_path(module_info_id: @mod_info.id)
      save_and_open_page
      click_link 'New Action'
      page.should have_content('New Action')
      fill_in 'module_action_name', :with => 'a test bom'
      fill_in 'module_action_desp', :with => 'a test spec'
      click_button 'Save'
      visit module_actions_path()
      page.should have_content('a test bom')
      #save_and_open_page
      #with bad data
      visit module_actions_path(module_info_id: @mod_info.id)
      click_link 'New Action'
      fill_in 'module_action_name', :with => 'a strange name'
      fill_in 'module_action_resource', :with => ''
      click_button 'Save'
      visit module_actions_path()
      page.should_not have_content('a strange name')
      
      
    end
  end
end
