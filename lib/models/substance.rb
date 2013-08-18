class Substance < ActiveRecord::Base
  # attributes: name

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :drugs, -> { distinct }

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
