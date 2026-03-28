[ ]
[ ]

[Skip to content](#branching-strategy)

[![logo](../../assets/logo.svg)](../.. "sr2silo")

sr2silo

Branching Strategy

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [Usage](../../usage/configuration/)
* [API Reference](../../api/loculus/)
* [Contributing](../)

[![logo](../../assets/logo.svg)](../.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](../..)
* [ ]

  Usage

  Usage
  + [Configuration](../../usage/configuration/)
  + [Multi-Organism Support](../../usage/organisms/)
  + [Deployment](../../usage/deployment/)
  + [Resource Requirements](../../usage/resource_requirements/)
* [ ]

  API Reference

  API Reference
  + [Loculus Integration](../../api/loculus/)
  + [Processing](../../api/process/)
  + [Data Schemas](../../api/schema/)
  + [V-Pipe Integration](../../api/vpipe/)
* [x]

  Contributing

  Contributing
  + [Overview](../)
  + [ ]

    Branching Strategy

    [Branching Strategy](./)

    Table of contents
    - [Main Branches](#main-branches)
    - [Feature Development](#feature-development)
    - [Releases](#releases)
    - [Hotfixes](#hotfixes)

# Branching Strategy

This project follows a simple but effective branching strategy centered around two main branches:

## Main Branches

1. **main**: The production-ready branch that always contains stable, releasable code.
2. Always deployable
3. Protected from direct pushes
4. Changes come from merged PRs from the `dev` branch
5. **dev**: The development branch where features and fixes are integrated.
6. Used for day-to-day development work
7. Integration branch for features and fixes
8. Code here should pass all tests but may not be production-ready
9. Pull requests target this branch

## Feature Development

When working on new features or bug fixes, follow these steps:

1. Create a feature branch from `dev`:

   ```
   git checkout dev
   git pull origin dev
   git checkout -b feature/your-feature-name
   ```
2. Make your changes, commit them, and push to your feature branch:

   ```
   git add .
   git commit -m "Descriptive commit message"
   git push origin feature/your-feature-name
   ```
3. Create a pull request from your feature branch to the `dev` branch.
4. After review and approval, your changes will be merged into the `dev` branch.

## Releases

When the `dev` branch contains enough features for a release or a scheduled release is due:

1. Create a pull request from `dev` to `main`.
2. Review the changes thoroughly.
3. After approval, merge the pull request to deploy to production.
4. Tag the release in the `main` branch with a version number.

## Hotfixes

For critical production issues:

1. Create a hotfix branch from `main`:

   ```
   git checkout main
   git pull origin main
   git checkout -b hotfix/issue-description
   ```
2. Fix the issue, commit, and push:

   ```
   git add .
   git commit -m "Fix critical issue"
   git push origin hotfix/issue-description
   ```
3. Create PRs to both `main` and `dev` branches to ensure the fix is applied to both branches.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)