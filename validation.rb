module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :presence, :format, :type

    def validate(name, type, *args)
      @presence = name if type == :presence
      @format = name, args if type == :format
      @type = name, args if type == :type
    end
  end

  module InstanceMethods
    def validate!
      validate_presence(instance_variable_get("@#{self.class.presence}")) if self.class.presence
      validate_format(instance_variable_get("@#{self.class.format[0]}"), self.class.format[1]) if self.class.format
      validate_type(instance_variable_get("@#{self.class.type[0]}"), self.class.type[1]) if self.class.type
    end

    def validate_presence(value)
      raise ArgumentError, 'Название станции или номер поезда не могут быть пустыми' if value.nil? || value.to_s == ''
    end

    def validate_format(value, regex)
      raise ArgumentError, 'Неверный формат' if value !~ regex.first
    end

    def validate_type(value, type_class)
      raise ArgumentError, 'Неверный класс' unless value.is_a? type_class.first
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
