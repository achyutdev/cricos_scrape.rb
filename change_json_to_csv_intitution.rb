require 'csv'
require 'json'
require 'rubygems'
require 'logger'

def read_data

  CSV.open("data/institutions.csv", "wb") do |csv|
    csv <<  [
      "Institution name",
      "Institution Trading Name",
      "State",
      "Cricos Provider Code",
      "Website",
      "Address",
      "Principal Executive Officer",
      "Title",
      "Phone",
      "Email"
    ]

    file = File.read('data/institutions.json')
    institutions = JSON.parse(file)
    institutions.each  do |institution|
      @state_name=''
      institution["contact_officers"].each do | contact |
        @peo_name  = contact["name"]
        @peo_title = contact["title"]
        @peo_phone = contact["phone"]
        @peo_email = contact["email"]
      end
      institution["locations"].each do |location|
        csv << [
          location["name"].to_s,
          institution["trading_name"].to_s,
          location["state"].to_s,
          institution['provider_code'].to_s,
          institution["website"],
          institution["postal_address"].to_s,
          @peo_name,
          @peo_title,
          @peo_phone,
          @peo_email
        ]
      end
    end

  end
end

read_data()
