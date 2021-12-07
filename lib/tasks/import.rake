require "csv"

task import: :environment do
  dwellings = CSV.read File.join("/", "tmp", "dwellings.csv"), headers: true

  ActiveRecord::Base.transaction do
    dwellings.each do |dwelling|
      development = Development.find_or_create_by(
        name: dwelling["Planning permission "]
      )

      planning_application = PlanningApplication.find_or_initialize_by(
        application_number: dwelling["Planning permission "]
      )

      development.planning_applications << planning_application
      development.save!

      Dwelling.create!(
        registered_provider: RegisteredProvider.find_or_create_by!(name: dwelling["Name of RP"]),
        development: development,
        uprn: dwelling["UPRN (if known)"],
        rp_internal_id: dwelling["Internal unit ID"],
        address: full_address(dwelling),
        bedrooms: dwelling["No. of bedrooms"] || 0,
        tenure: dwelling["DXW Tenure"].downcase,
        tenure_product: dwelling["DXW Tenure Product"],
        wheelchair_accessible: dwelling["Wheelchair accessible"] == "Yes",
        wheelchair_adaptable: dwelling["Wheelchair adaptable"] == "Yes",
        bulk_import: true
      )

      print "."
    end
  end
end

def full_address(dwelling)
  [
    dwelling["Flat/Unit No."],
    dwelling["Address"],
    dwelling["Post code"]
  ].reject(&:blank?).join(" ")
end
