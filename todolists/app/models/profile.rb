class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female) }

  validate :name_given, :Sue

  def name_given
    if (first_name == nil && last_name == nil)
      errors.add(:fisrt_name, "First name or last name must be given.")
      errors.add(:last_name, "First name or last name must be given.")
    end
  end

  def Sue
    if (gender == "male" && first_name == "Sue")
      errors.add(:first_name, "Males cannot have the first name Sue.")
    end
  end

  def self.get_all_profiles (min, max)
    return Profile.where("birth_year BETWEEN :min AND :max", min: min, max: max).order(:birth_year)
  end
end
