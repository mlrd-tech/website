# mlrd.tech Website

Website has two parts:

1. Main: located in `content/`, `layout/`, and `static/`
2. Docs: loccated in `docs/`

Both built with Hugo but are separate sites in development, combined on build/deploy into `public/`.
`public/` is git-controlled; full site (main + docs) built locally, not by GitHub Actions.
