---
name: python
description: This tool manages the Awesome Python ecosystem by maintaining the README source of truth and executing the Python-based build pipeline for the project website. Use when user asks to add new library entries, update GitHub star counts, build the website, or run local previews and tests.
homepage: https://github.com/vinta/awesome-python
metadata:
  docker_image: "quay.io/biocontainers/python:3.13"
---

# python

## Overview
This skill provides the procedural knowledge required to manage the Awesome Python ecosystem. It focuses on maintaining the single source of truth (README.md), ensuring all library entries meet strict "Rising Star" or "Hidden Gem" criteria, and using the Python-based build pipeline to generate the awesome-python.com website. It is designed to help maintainers and contributors follow the project's specific formatting rules and automation workflows.

## Maintenance and Development Patterns

### Environment Management
The project uses `uv` for dependency management and requires Python 3.13+.
- **Initialize environment**: Run `make install` to sync dependencies via `uv`.
- **Update star counts**: Run `make fetch_github_stars` to refresh the GitHub star data stored in `website/data/`.

### Adding New Entries
All entries must be added to `README.md` following these strict formatting rules:
- **Format**: `- [pypi-name](https://github.com/owner/repo) - Description ending with period.`
- **Naming**: Use the canonical PyPI package name as the display name. If the project is not on PyPI, use the GitHub repository name.
- **Ordering**: Entries must be placed in alphabetical order within their respective categories or subcategories.
- **Standard Library**: For built-in modules, use the format: `- [module](https://docs.python.org/3/library/module.html) - (Python standard library) Description.`

### Quality Requirements
Before adding a project, verify it meets the following:
- **Activity**: Commits within the last 12 months.
- **Stability**: Production-ready (not alpha/beta).
- **Popularity**: Generally 100+ stars. "Rising Stars" should have 5,000+ stars in < 2 years.
- **Hidden Gems**: Require strong justification and must be at least 6 months old.

### Build and Test Workflow
- **Build Website**: Run `make build` to execute `website/build.py`. This parses the README and renders HTML using Jinja2.
- **Local Preview**: Run `make preview`. This builds the site, starts a local server at `127.0.0.1:8000`, and watches for file changes to trigger auto-rebuilds.
- **Testing**: Run `make test` to execute the pytest suite located in `website/tests/`. This validates the build pipeline and README parsing logic.

### Repository Structure
- `README.md`: The source of truth for all content.
- `website/`: Contains the static site generator logic.
- `Makefile`: The primary interface for all maintenance tasks.
- `pyproject.toml`: Defines dependencies and tool configurations.



## Subcommands

| Command | Description |
|---------|-------------|
| chmod | Change file mode bits |
| pip | Manage the Python package index. |
| python | Execute Python scripts or modules. |
| python3 | Execute Python scripts or modules. |

## Reference documentation
- [CLAUDE.md](./references/github_com_vinta_awesome-python_blob_master_CLAUDE.md)
- [CONTRIBUTING.md](./references/github_com_vinta_awesome-python_blob_master_CONTRIBUTING.md)
- [Makefile](./references/github_com_vinta_awesome-python_blob_master_Makefile.md)
- [README.md](./references/github_com_vinta_awesome-python_blob_master_README.md)