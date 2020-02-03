# frozen_string_literal: true
module Model
  def to_hsh
    hash = {}
    instance_variables.each do |var|
      hash[var_name(var)] = instance_variable_get(var)
    end
    hash.delete_if { |key, _value| key == 'platform' }
  end

  def var_name(var)
    var.to_s.delete_prefix('@')
  end
end
