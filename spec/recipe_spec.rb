require('spec_helper')

describe(Recipe) do
  it{ should have_and_belong_to_many(:categories)}

  describe("upcase") do
    it("upcases the first letter of a recipe or category") do
      recipe1 = Recipe.create({:name => "borscht"})
      expect(recipe1.upcase().to(eq("Borscht")))
    end
  end
end