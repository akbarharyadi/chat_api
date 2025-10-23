# Chat API

API-only Rails application that exposes chatrooms, persists messages, and pushes real-time updates over Action Cable.

## Local Development

```bash
docker compose up --build
```

Services:

- `web`: Rails API at `http://localhost:3000`
- `db`: Postgres 16
- `redis`: Redis 7 (Action Cable backend)

After the stack is up, seed sample data:

```bash
docker compose run --rm web bundle exec rails db:seed
```

Run the test suite:

```bash
docker compose run --rm web bash -lc "bundle exec rspec -fd"
```

### API Contract Hints

- Swagger UI: visit `http://localhost:3000/docs` to browse the live documentation powered by `docs/openapi.yaml`.
- Frontend integration guide: see `docs/frontend_integration.md` for REST/WebSocket usage examples.
- Deployment reference: see `docs/deployment_ubuntu.md` for GitHub Actions-driven rollout steps.

## Frontend Integration

Reference `docs/frontend_integration.md` for:

- Sample REST requests (list/create chatrooms, post messages).
- Action Cable subscription example code for JavaScript clients.
- Recommendations for handling validation errors and stable user identifiers.

### CORS Configuration

- Default allowed origins: `http://localhost:5173` and `http://localhost:3000`.
- Override by setting `CORS_ORIGINS` (space-separated list) before starting the server or containers.

## Deployment

- Automated CI: `.github/workflows/ci.yml`
- Automated deploy: `.github/workflows/deploy.yml`
- Detailed server setup: `docs/deployment_ubuntu.md`

## Authors

- **Akbar Haryadi** — [github.com/akbarharyadi](https://github.com/akbarharyadi)
