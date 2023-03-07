require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(nameable_obj = Nameable.new)
    @nameable_obj = nameable_obj
  end

  def correct_name
    @nameable_obj.correct_name
  end
end
