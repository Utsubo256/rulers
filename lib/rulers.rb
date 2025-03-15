# frozen_string_literal: true

require_relative "rulers/version"
require 'rulers/routing'

module Rulers
  class Error < StandardError; end

  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, { 'content-type' => 'text/html' }, []]
      end

      if env['PATH_INFO'] == '/'
        return [200, { 'content-type' => 'text/html' }, ['root path!!!']]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { 'content-type' => 'text/html' }, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
