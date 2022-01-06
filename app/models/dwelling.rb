class Dwelling < ApplicationRecord
  belongs_to :development
  belongs_to :registered_provider, optional: true

  audited(
    associated_with: :development,
    if: :audit_changes?,
    on: %i[create update destroy],
    comment_required: true,
    except: %i[address uprn registered_provider_id rp_internal_id tenure_product]
  )

  attr_accessor :audit_planning_application_id, :bulk_import

  TENURES = %w[open social intermediate other].freeze
  TENURE_PRODUCTS = [
    "Build for sale",
    "Build to rent",
    "Social rent",
    "Affordable rent",
    "London Affordable Rent",
    "Social rent equivalent",
    "Leasehold social",
    "London Living Rent",
    "Community Land Trust",
    "Discount market sale",
    "Starter Home",
    "Shared equity",
    "Discount market rent",
    "Shared ownership",
    "London Living Rent Equivalent",
    "First homes",
    "Housing for older people",
    "Supported housing",
    "Rough sleepers initiative"
  ].freeze

  scope :within_s106, -> { where(tenure: %w[social intermediate]) }

  validates :tenure, presence: true
  validates :habitable_rooms, presence: true, unless: :bulk_import
  validates :bedrooms, presence: true
  validates :reference_id, presence: true, uniqueness: {scope: :development}, unless: :bulk_import

  delegate :audit_changes?, to: :development

  private

  def write_audit(attrs)
    attrs[:planning_application_id] = audit_planning_application_id if audit_planning_application_id.present?
    super
  end
end
