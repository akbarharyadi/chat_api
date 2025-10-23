class DocsController < ApplicationController
  def openapi
    render plain: Rails.root.join("docs", "openapi.yaml").read, content_type: "application/yaml"
  end

  def swagger
    html = <<~HTML
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="utf-8">
          <title>Chat API Reference</title>
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5/swagger-ui.css" />
          <style>
            body { margin: 0; padding: 0; }
            #swagger-ui { margin: 0 auto; }
          </style>
        </head>
        <body>
          <div id="swagger-ui"></div>
          <script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5/swagger-ui-bundle.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5/swagger-ui-standalone-preset.js"></script>
          <script>
            document.addEventListener('DOMContentLoaded', function() {
              SwaggerUIBundle({
                url: window.location.origin + "/docs/openapi.yaml",
                dom_id: '#swagger-ui',
                presets: [SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset],
                layout: "StandaloneLayout"
              });
            });
          </script>
        </body>
      </html>
    HTML

    render plain: html, content_type: "text/html"
  end
end
