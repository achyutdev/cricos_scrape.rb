require 'csv'
require 'json'
require 'rubygems'
require 'logger'

def read_data

  CSV.open("data/courses.csv", "wb") do |csv|
    csv <<  [
      "Institution name",
      "Institution Trading Name",
      "Cricos Provider Code",
      "Institution Type",
      "Website",
      "Address",
      # "Principal Executive Officer",
      # "Title",
      # "Phone",
      # "Email",
      # "International Student Conact",
      # "Title",
      # "Phone",
      # "Email",
      "Course Location",
      "Course Name",
      "Cricos Code",
      "Broad Field",
      "Narrow Field",
      "Course Language",
      "Course Level",
      "Durations (in weeks)",
      "Tuition Fee",
      "Non Tution Fee",
      "Estimated Total"
    ]

    file = File.read('data/courses.json')
    institutions = JSON.parse(file)
    institutions.each  do |institution|

      institution_name          = institution["institution_name"]
      institution_trading_name  = institution["institution_trading_name"]
      cricos_provider_code      = institution["cricos_provider_code"]
      institution_type          = institution["institution_type"]
      website                   = institution["website"]
      address                   = institution["institution_postal_address"]



      # peo_details = institution["contact_officers"][0]
      # principle_exe_officer       = peo_details['name']
      # principle_exe_officer_title = peo_details["title"]
      # principle_exe_officer_phone = peo_details["phone"]
      # principle_exe_officer_email = peo_details["email"]

      # international_student_contact          = institution["contact_officers"][1]
      # international_student_person           = international_student_contact['name']
      # international_student_person_title     = international_student_contact["title"]
      # international_student_person_phone     = international_student_contact["phone"]
      # international_student_person_email     = international_student_contact["email"]

      course_name           = institution["course_name"]
      course_code           = institution["course_code"]
      broad_field           = institution["broad_field"]
      narrow_field          = institution["narrow_field"]
      course_level          = institution["course_level"]
      course_language       = institution["course_language"]
      duration              = institution["duration"]
      tuition_fee           = institution["tuition_fee"]
      non_tuition_fee       = institution["non_tuition_fee"]
      total_cost            = institution["total_cost"]



      institution["locations"].each do |location|

        csv << [
          institution_name,
          institution_trading_name,
          cricos_provider_code,
          institution_type,
          website,
          address,
          # principle_exe_officer,
          # principle_exe_officer_title,
          # principle_exe_officer_phone,
          # principle_exe_officer_email,
          # international_student_person,
          # international_student_person_title,
          # international_student_person_phone,
          # international_student_person_email,
          location,
          course_name,
          course_code,
          broad_field,
          narrow_field,
          course_language,
          course_level,
          duration,
          tuition_fee,
          non_tuition_fee,
          total_cost
        ]
      end
    end

  end
end

read_data()
