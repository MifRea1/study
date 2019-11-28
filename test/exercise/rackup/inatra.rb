module Inatra
  class << self
    def routes(&block)
      return @routes unless block_given?
      @routes = Hash.new(Hash.new(-> { [405, {}, 'Method Not Allowed'] }))
      class_exec(&block)
    end

    def call(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']
      routes[method][path].call
    end

    def method_missing(method, *paths, &response)
      paths.each do |path|
        routes[method] = Hash.new(-> { [404, {}, 'Not Found'] }) unless routes.key?(method)
        routes[method][path] = response
      end
    end
  end
end
