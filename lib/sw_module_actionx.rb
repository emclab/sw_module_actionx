require "sw_module_actionx/engine"

module SwModuleActionx
  mattr_accessor :module_info_class
  
  def self.module_info_class
    @@module_info_class.constantize
  end
end
