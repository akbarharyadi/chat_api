# Chat API

API-only Rails application that exposes chatrooms, persists messages, and pushes
real-time updates over Action Cable.

## Local Development

```
docker compose up --build
```

Services:

- `web`: Rails API at `http://localhost:3000`
- `db`: Postgres 16
- `redis`: Redis 7 (Action Cable backend)

After the stack is up, seed sample data:

```
docker compose run --rm web bundle exec rails db:seed
```

Run the test suite:

```
docker compose run --rm web bash -lc "bundle exec rspec -fd"
```

### API Contract Hints

- Swagger UI: visit `http://localhost:3000/docs` to browse the live documentation powered by `docs/openapi.yaml`.
