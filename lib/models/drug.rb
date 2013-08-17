class Drug < ActiveRecord::Base
  # attributes: name, form, manufacturer, distribution, info

  has_and_belongs_to_many :substances

  validates :name, presence: true, uniqueness: true

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
