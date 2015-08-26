class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:name, :presence => true)
  before_save(:upcase)

  private

  def upcase
    self.name=(name.downcase.titlecase)
  end
end