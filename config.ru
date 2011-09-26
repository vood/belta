# This file is used by Rack-based servers to start the application.
Encoding.default_external = "UTF-8"
require ::File.expand_path('../config/environment',  __FILE__)
run Belta::Application
