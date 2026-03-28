[ ]
[ ]

[Skip to content](#contributing)

[![logo](../assets/logo.svg)](.. "sr2silo")

sr2silo

Overview

Initializing search

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](..)
* [Usage](../usage/configuration/)
* [API Reference](../api/loculus/)
* [Contributing](./)

[![logo](../assets/logo.svg)](.. "sr2silo")
sr2silo

[sr2silo](https://github.com/cbg-ethz/sr2silo "Go to repository")

* [Home](..)
* [ ]

  Usage

  Usage
  + [Configuration](../usage/configuration/)
  + [Multi-Organism Support](../usage/organisms/)
  + [Deployment](../usage/deployment/)
  + [Resource Requirements](../usage/resource_requirements/)
* [ ]

  API Reference

  API Reference
  + [Loculus Integration](../api/loculus/)
  + [Processing](../api/process/)
  + [Data Schemas](../api/schema/)
  + [V-Pipe Integration](../api/vpipe/)
* [x]

  Contributing

  Contributing
  + [ ]

    Overview

    [Overview](./)

    Table of contents
    - [Ways to Contribute](#ways-to-contribute)
    - [Development Setup](#development-setup)

      * [Environment Options](#environment-options)
      * [After Setup](#after-setup)
      * [Running Tests](#running-tests)
    - [Getting Started](#getting-started)
    - [Code Guidelines](#code-guidelines)
    - [Questions?](#questions)
  + [Branching Strategy](branching-strategy/)

# Contributing

We welcome contributions to sr2silo! Whether you're fixing bugs, adding features, improving documentation, or reporting issues, your help is appreciated.

## Ways to Contribute

* **Report bugs**: Open an issue describing the problem and how to reproduce it
* **Suggest features**: Open an issue to discuss new functionality
* **Submit pull requests**: Fix bugs or implement new features
* **Improve documentation**: Help make the docs clearer and more complete

## Development Setup

We use [Poetry](https://python-poetry.org/) for dependency management and packaging. The project provides multiple environment configurations in the `environments/` directory.

### Environment Options

**Core Environment** (basic usage):

```
make setup
```

**Development Environment** (recommended for contributors):

```
make setup-dev
```

**Workflow Environment** (for Snakemake workflows):

```
make setup-workflow
```

**All Environments**:

```
make setup-all
```

### After Setup

```
conda activate sr2silo-dev
poetry install --with dev
poetry run pre-commit install
```

### Running Tests

```
make test
# or directly:
pytest
```

## Getting Started

1. Fork the repository
2. Clone your fork:

   ```
   git clone https://github.com/YOUR_USERNAME/sr2silo.git
   cd sr2silo
   ```
3. Set up the development environment (see above)
4. Create a feature branch following our [branching strategy](branching-strategy/)
5. Make your changes and run tests
6. Submit a pull request to the `dev` branch

## Code Guidelines

* Follow existing code style and patterns
* Add tests for new functionality
* Update documentation as needed
* Keep commits focused and write descriptive commit messages

## Questions?

Open an issue on GitHub if you have questions about contributing.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)