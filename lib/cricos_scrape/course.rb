module CricosScrape
  class Course < Struct.new(:institution_trading_name,:institution_name,:cricos_provider_code,:institution_type, :website, :institution_postal_address,:course_id, :course_name, :course_code, :field_of_education, :broad_field, :narrow_field, :detailed_field, :course_level, :work_component, :course_language, :duration,:tuition_fee, :non_tuition_fee, :total_cost,:locations)
  end
end