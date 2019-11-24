module Inatra
  class << self
    def routes(&block)
      if block_given?
        @routes = {}
        class_exec(&block)
      else
        @routes
      end
    end

    def call(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']
      return [405, {}, 'Method Not Allowed'] unless routes.key?(method)
      routes[method][path]&.call || [404, {}, 'Not Found']
    end

    def method_missing(name, *paths, &response)
      paths.each do |path|
        routes[name] = {} unless routes.key?(name)
        routes[name][path] = response
      end
    end
  end
end
