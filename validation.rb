module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validates

    def validate(name, type, *args)
      @validates ||= []
      @validates << { variable: name, type: type, args: args[0] }
    end
  end

  module InstanceMethods
    def validate!
      @validates = self.class.instance_variable_get(:@validates)
      @validates.each do |validate|
        value = instance_variable_get("@#{validate[:variable]}")
        send("validate_#{validate[:type]}", value, *validate[:args])
      end
    end

    def validate_presence(value)
      raise ArgumentError, 'Название станции или номер поезда не могут быть пустыми' if value.nil? || value.to_s == ''
    end

    def validate_format(value, regex)
      raise ArgumentError, 'Неверный формат' if value !~ regex
    end

    def validate_type(value, type_class)
      raise ArgumentError, 'Неверный класс' unless value.is_a? type_class
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
