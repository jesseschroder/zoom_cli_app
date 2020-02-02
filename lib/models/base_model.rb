require_relative 'model'
class BaseModel
  include Model

  def initialize(options = {})
    options.each { |key, value| instance_variable_set("@#{key}", value) }
    instance_variables.each { |var| self.class.send(:attr_accessor, var.to_s.delete("@")) }
  end
end
