module Polar
  class Cursor
    include Enumerable
    ITEMS_PER_PAGE = 50

    def initialize(api_key, secret_key, session_key, domain_klass, params)
      @params, @api_key, @secret_key, @session_key, @domain_klass, @params  = api_key, secret_keym session_key, domain_klass, params
      @current_page = 0
      @fetched_current_page = false
    end

    #Each will return the first page of results
    def each(&block)
      @current_page += 1
      fetch_current_page if !@fetched_current_page
      @items.each { |i| block.call i }
      @fetched_current_page = false
    end

    def next_page?
      @items.count < ITEMS_PER_PAGE
    end

    def total_items
      fetch_current_page if @total_items.nil?
      @total_items
    end

    def [](index)
      fetch_current_page if !@fetched_current_page
      @items[index]
    end

    private

    def page_request
      request = Polar::Request.new(params)
      request.response
    end

    def fetch_current_page
      options = @options.merge({ :page => @current_page, :count => @items_per_page })
      response = page_request(params)

      @items = []
      response.each do |domain_object|
        @items << @domain_object.new(domain_object)
      end
      @fetched_current_page = true
    end

  end
end
