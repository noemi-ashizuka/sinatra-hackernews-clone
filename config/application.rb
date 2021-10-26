require 'sinatra'
require 'active_record'
require 'sqlite3' if development?
require 'yaml'

# This is some boilerplate code to read the config/database.yml file
# And connect to the database
config_path = File.join(File.dirname(__FILE__), "database.yml")
ActiveRecord::Base.configurations = YAML.load_file(config_path)

if production?
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
else
  ActiveRecord::Base.establish_connection(:development)
end

# Set a logger so that you can view the SQL actually performed by ActiveRecord
logger = Logger.new($stdout)
logger.formatter = proc do |_severity, _datetime, _progname, msg|
  "#{msg}\n"
end
ActiveRecord::Base.logger = logger

# Load models
Dir["#{__dir__}/../app/models/*.rb"].sort.each { |file| require file }


# Discard warning message for i18n errors
I18n.enforce_available_locales = false