module MotionResource
  module Resource

    def self.included(base)
      base.extend(MotionResource::Resource::UtilityClassMethods::ClassMethods)      
      base.extend(MotionResource::Resource::ModelMethods::ClassMethods)      
      base.extend(ClassMethods)
      base.instance_variable_set("@_columns", [])      
      base.instance_variable_set("@_column_hashes", {})
    end


    module ClassMethods

      def base_url
        Config.base_url
      end

      def self.get(url, options={}, &block)
        create_query(url, :get, options, block)
      end

      def findAll(options={}, &block)        
        call_server(:get, "#{base_url}#{resource_name}.json", options, block)
      end

      def find(id, options={}, &block)
        call_server(:get, "#{base_url}#{resource_name}/#{id}.json", options, block)
      end

      def create(resource, options={}, &block)
         BubbleWrap::HTTP::Query.new( "#{base_url}#{resource_name}.json", :post, { payload: resource.payload } )
      end

      def update(resource, options={}, &block)
         BubbleWrap::HTTP::Query.new( "#{base_url}#{resource_name}/#{resource.id}.json", :post, 
                                      { payload: resource.payload, headers: {'X_HTTP_METHOD_OVERRIDE' => 'put'} } )
      end

      def delete(resource, options={}, &block)
         BubbleWrap::HTTP::Query.new( "#{base_url}#{resource_name}/#{resource.id}.json", :post, 
                                      { payload: resource.payload, headers: {'X_HTTP_METHOD_OVERRIDE' => 'delete'} } )
      end

      def resource_name
        underscore(self.to_s)+"s" # FIXME: get Rails inflections
      end

      def call_server(method, url, options, block)
        delegator = block if block   
        BubbleWrap::HTTP.send(method, url, options ) do |response|
          if response.ok?
            json = BubbleWrap::JSON.parse(response.body.to_str)
            # FIXME: translate json --> resources
            response.instance_variable_set("@body", json) # replace response with translated JSON.
          else
            # FIXME: define how to handle errors (i.e rails validations should be translated to JSON)  
          end
          if delegator.respond_to?(:call)
            delegator.call( response, self )            
          end
        end        
      end

    end # ClassMethods

    # Instance Methods 

    def initialize(options = {})
      @data ||= {}
      
      columns.each do |col|
        options[col] ||= self.class.default(col)
        cast_value = cast_to_type(col, options[col])
        @data[col] = cast_value
      end
    end    

    def show(options={})
    end

    def save(options={})
      id.nil? ? self.class.create(self) : self.class.update(self)
    end

    def destroy(options={})
      # assertRestCall(ActiveResource.destroy(Department, {id:1}),  "/departments/1.json", "POST"); // DELETE
      # assertThat(lastHttpService.headers, hasProperties({X_HTTP_METHOD_OVERRIDE:'delete'}));      
    end

    # FIXME: try to avoid this and let access by keys
    def payload
      columns.inject({}) {|h, c| h[c] = self.send(c); h }      
    end

    # Introspection Methods (borrow from MotionModel)

  end
end
