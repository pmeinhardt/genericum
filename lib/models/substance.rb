class Substance < ActiveRecord::Base
  # attributes: name

  has_and_belongs_to_many :drugs

  validates :name, presence: true, uniqueness: true

  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
