require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    if @nameable_obj.correct_name.length > 10
      @nameable_obj.correct_name[0..9]
    else
      @nameable_obj.correct_name
    end
  end
end
