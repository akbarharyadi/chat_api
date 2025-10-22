require "rails_helper"

RSpec.describe "Docs API", type: :request do
  before { host! "localhost" }

  describe "GET /openapi.yaml" do
    it "serves the OpenAPI document" do
      get "/openapi.yaml"

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("application/yaml")
      expect(response.body).to include("openapi: 3.0.3")
    end
  end

  describe "GET /docs" do
    it "serves the Swagger UI shell" do
      get "/docs"

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq("text/html")
      expect(response.body).to include("SwaggerUIBundle")
    end
  end
end
