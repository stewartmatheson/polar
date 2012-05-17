module Polar
  class Cursor
    include Enumerable
    ITEMS_PER_PAGE = 500

    def initialize(api_key, secret_key, session_key, domain_klass, params)
      @api_key, @secret_key, @session_key, @domain_klass, @params = api_key, secret_key, session_key, domain_klass, params
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
      if @items
        return @items.count <= ITEMS_PER_PAGE
      elsif !@items && @current_page == 0
        return true
      else
        raise("Items are nil and they should not be.")
      end
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

    def page_request(params)
      request = Polar::Request.new(@api_key, @secret_key, @session_key, params)
      request.response
    end

    def fetch_current_page
      params = @params.merge({ :page => @current_page, :count => ITEMS_PER_PAGE })
      response = page_request(params)

      @items = []
      response.each do |response_item|
        @items << @domain_klass.new(response_item)
      end
      @fetched_current_page = true
    end

  end
end
