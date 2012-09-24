module MotionResource
  module Resource
    module UtilityClassMethods

      def self.included(base)
        base.extend(ClassMethods)      
      end

      module ClassMethods

        def underscore(camel_cased_word)
          word = camel_cased_word.to_s.dup
          acronym_regex = //
          word.gsub!(/::/, '/')
          # word.gsub!(/(?:([A-Za-z\d])|^)(#{acronym_regex})(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
          word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
          word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
          word.tr!("-", "_")
          word.downcase!
          word
        end  
        
      end
    end
  end
end