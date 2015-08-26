class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  validates(:name, :presence => true)
  before_save(:upcase)
  scope :quiche, -> { where(name: "Quiche")}
  scope :beets, -> { where("ingredients LIKE ?", "b%")}

  private

  def upcase
    self.name=(name.downcase.titlecase)
  end
end