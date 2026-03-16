# AGENTS.md

## Cursor Cloud specific instructions

This is a Jekyll-based static blog (CodingTed). The tech stack is Ruby + Jekyll + Node.js (for ESLint).

### 1. Prerequisites (installed by VM snapshot)

- **Ruby 3.2** with `build-essential` and `zlib1g-dev` (via `sudo apt-get install -y ruby-full build-essential zlib1g-dev`)
- **Bundler 2.4.6** (via `sudo gem install bundler:2.4.6`)
- **Node.js 22.x** (pre-installed)

### 2. Key commands

| Task | Command |
|---|---|
| Install Ruby gems | `sudo bundle install` (from `/workspace`) |
| Install npm deps | `npm install --legacy-peer-deps` |
| Build site | `npm run build` → `bundle exec jekyll build` |
| Dev server | `bundle exec jekyll serve -w --drafts --host 0.0.0.0 --port 4000` |
| Lint JS | `npm run lint` (requires `.eslintrc` — not present in repo) |

### 3. Gotchas

- **Port 80 requires root**: The `npm start` script binds to port 80, which needs root. Use `bundle exec jekyll serve -w --drafts --host 0.0.0.0 --port 4000` instead for non-root dev.
- **Do NOT use `bundle config set --local path 'vendor/bundle'`**: Jekyll will try to process files inside `vendor/bundle` because the repo's `_config.yml` exclude list does not include `vendor/`. Always install gems to the system path with `sudo bundle install`.
- **npm install needs `--legacy-peer-deps`**: The `eslint-plugin-mocha` peer dependency conflicts with `eslint@5`. Use `npm install --legacy-peer-deps`.
- **Gem source**: The `Gemfile` uses `https://gems.ruby-china.com` (Chinese mirror). This works in the cloud environment but may be slower; do not change the source as it is repo configuration.
- **No ESLint config**: The repo has no `.eslintrc*` file, so `npm run lint` fails. This is a pre-existing repo gap.
- **No automated tests**: `npm test` is a placeholder that echoes an error. There are no unit/integration tests to run.
