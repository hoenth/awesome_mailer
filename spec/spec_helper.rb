# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start
require 'rails/all'
require 'rspec'
require 'ostruct'
require 'awesome_mailer'
require 'pry'
require 'capybara'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

AwesomeMailer::Base.prepend_view_path 'spec/views'
AwesomeMailer::Base.config.assets_dir = 'spec/assets'

class TestMailer < AwesomeMailer::Base
  def render_template(template_name)
    mail(from: "flip@x451.com", to: "flip@x451.com", subject: "Test e-mail") do |format|
      format.html { render template_name }
    end
  end

  def render_multipart_template(template_name)
     mail(from: "flip@x451.com", to: "flip@x451.com", subject: "Test multipart e-mail") do |format|
      format.html { render template_name }
      format.text { render template_name }
    end
  end
end

module AwesomeMailerTestHelper
  class AwesomeStruct < OpenStruct
    def [](key)
      send(key)
    end

    def []=(key, value)
      send("#{key}=", value)
    end
  end

  def file_root
    File.expand_path('public', File.dirname(__FILE__))
  end

  def load_asset_pipeline
    asset_pipeline = AwesomeStruct.new(
      "test.css" => File.read(File.join('spec', 'assets', 'stylesheets', 'test.css'))
    )
    assets = AwesomeStruct.new(prefix: '/stylesheets')
    action_mailer = AwesomeStruct.new(asset_host: nil)
    action_controller = AwesomeStruct.new(asset_host: nil)
    allow(Rails).to receive(:application).and_return(AwesomeStruct.new(assets: asset_pipeline))
    allow(Rails).to receive(:configuration).and_return(AwesomeStruct.new(assets: assets, action_mailer: action_mailer, action_controller: action_controller))
  end

  def load_file_server
    server = Rack::Server.new(app: Rack::Directory.new(file_root), Port: "9876")
    @file_server = fork { server.start }
    sleep 2
  end

  def stop_file_server
    `kill -9 #{@file_server}`
  end

  def render_email(template_name)
    email_body = TestMailer.render_template(template_name).body.to_s
    Capybara.string(email_body)
  end
end

RSpec.configure do |config|
  config.include AwesomeMailerTestHelper

  config.before do
    allow(Rails).to receive(:configuration).and_return(AwesomeMailerTestHelper::AwesomeStruct.new)      
    # since we don't have an environment file, we need to stub Rails.root, as
    # it is when the environment file is loaded that the root is set.
    allow(Rails).to receive(:root).and_return(Pathname.new(File.dirname(__FILE__)))
  end
end
