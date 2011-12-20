# app\config\initializers\quiet_assets.rb
#Rails.application.assets.logger = Logger.new('/dev/null')

# ref:http://journal.sooey.com/185
Rails.application.assets.logger = Logger.new('nul') #ForWindows
#Rails.application.assets.logger = Logger.new('/dev/null') #ForLinux


Rails::Rack::Logger.class_eval do
  def before_dispatch_with_quiet_assets(env)
    before_dispatch_without_quiet_assets(env) unless env['PATH_INFO'].index("/assets/") == 0
  end
  alias_method_chain :before_dispatch, :quiet_assets
end