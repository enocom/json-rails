require "spec_helper"

describe "movies API" do
  describe "GET /movies" do
    it "returns all the movies" do
      FactoryGirl.create :movie, title: "The Hobbit"
      FactoryGirl.create :movie, title: "The Fellowship of the Ring"

      get "/movies", "", {"Accept" => "application/json"}

      response_body = JSON.parse(response.body)
      expect(response.status).to be 200
      expect(response_body.size).to eq 2
    end
  end

  describe "GET /movies/:id" do
    it "returns a requested movie" do
      m = FactoryGirl.create :movie, title: "2001: A Space Odyssy"

      get "/movies/#{m.id}", "", {"Accept" => "application/json"}

      response_body = JSON.parse(response.body)
      expect(response.status).to be 200
      expect(response_body["title"]).to eq "2001: A Space Odyssy"
    end
  end

  describe "PUT /movies/:id" do
    it "updates a movie" do
      m = FactoryGirl.create :movie, title: "Star Battles"

      put "/movies/#{m.id}", { movie: { title: "Star Wars" } }
      expect(response.status).to be 204
      expect(m.reload.title).to eq "Star Wars"
    end
  end
end