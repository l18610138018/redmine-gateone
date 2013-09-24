Redmine::Plugin.register :gateone do
  name 'gateone plugin'
  author 'Brian Smith'
  description 'Provide a simple, configurable, interface to a gateone instance'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  settings :default => { 'empty' => true }, :partial => 'settings/gateone_settings'
  permission :gateone, { :gateone => [:index] }, :public => true
  menu :project_menu, :gateone_main, { :controller => 'gateone', :action => 'index' }, :after => :activities, :caption => 'Shell', :param => :project_id
end
