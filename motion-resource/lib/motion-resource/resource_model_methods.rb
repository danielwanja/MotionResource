# This code is borrowed from the motion-model gem
module MotionResource
  module Resource
    module ModelMethods

      def self.included(base)
        base.extend(ClassMethods)      
      end      

      module ClassMethods
        # Macro to define names and types of columns. It can be used in one of
        # two forms:
        #
        # Pass a hash, and you define columns with types. E.g.,
        #
        #   columns :name => :string, :age => :integer
        #
        # Pass a hash of hashes and you can specify defaults such as:
        #
        #   columns :name => {:type => :string, :default => 'Joe Bob'}, :age => :integer
        #   
        # Pass an array, and you create column names, all of which have type +:string+.
        #   
        #   columns :name, :age, :hobby
        def columns(*fields)
          return @_columns.map{|c| c.name} if fields.empty?

          col = Column.new
          
          case fields.first
          when Hash
            fields.first.each_pair do |name, options|
              raise ArgumentError.new("you cannot use `description' as a column name because of a conflict with Cocoa.") if name.to_s == 'description'
              
              case options
              when Symbol, String
                add_field(name, options)
              when Hash
                add_field(name, options[:type], options[:default])
              else
                raise ArgumentError.new("arguments to fields must be a symbol, a hash, or a hash of hashes.")
              end
            end
          else
            fields.each do |name|
              add_field(name, :string)
            end
          end

          # Id must be specified, this allows multiple calls to columns
          # unless self.respond_to?(:id)
          #   add_field(:id, :integer)
          # end
        end

        def add_field(name, options, default = nil) #nodoc
          col = Column.new(name.to_sym, options, default)
          @_columns.push col
          @_column_hashes[col.name.to_sym] = col
        end

        def column_named(name)
          @_column_hashes[name.to_sym]
        end

        def column?(column)
          respond_to?(column)
        end

        def type(column)
          column_named(column).type || nil
        end

        def default(column)
          column_named(column).default || nil
        end

      end # ClassMethods

      # Instance Methods
      def initialize(options = {})
        @data ||= {}
        columns.each do |col|
          options[col] = self.class.default(col) if options[col].nil?
          cast_value = cast_to_type(col, options[col])
          @data[col] = cast_value
        end
        self
      end    

      def cast_to_type(column_name, arg)
        return nil if arg.nil?
        return_value = arg
        
        case type(column_name)
        when :string
          return return_value = arg.to_s
        when :int, :integer
          return return_value = arg.is_a?(Integer) ? arg : arg.to_i
        when :float, :double
          return return_value = arg.is_a?(Float) ? arg : arg.to_f
        when :date
          return arg if arg.is_a?(NSDate)
          return return_value = NSDate.dateWithNaturalLanguageString(arg, locale:NSUserDefaults.standardUserDefaults.dictionaryRepresentation)
        when :boolean
          return arg.is_a?(TrueClass) ? true : false # FIXME: test the hell out of that
        end
        raise ArgumentError.new("type #{column_name} : #{type(column_name)} is not possible to cast.")
      end

      def to_s
        columns.each{|c| "#{c}: #{self.send(c)}"}
      end

      def column?(target_key)
        self.class.column?(target_key.to_sym)
      end

      def columns
        self.class.columns
      end

      def column_named(name)
        self.class.column_named(name.to_sym)
      end

      def type(field_name)
        self.class.type(field_name)
      end
      
      # Modify respond_to? to add model's attributes.
      alias_method :old_respond_to?, :respond_to?
      def respond_to?(method)
        column_named(method) || old_respond_to?(method)
      end


      def method_missing(method, *args, &block)
        base_method = method.to_s.gsub('=', '').to_sym
        
        col = column_named(base_method)
        
        if col
          if method.to_s.include?('=')
            @dirty = true
            return @data[base_method] = self.cast_to_type(base_method, args[0])
          else
            return @data[base_method]
          end
        else
          raise NoMethodError, <<-ERRORINFO
                                method: #{method}
                                args:   #{args.inspect}
                                in:     #{self.class.name}
                                ERRORINFO
        end
      end      


    end
  end
end

