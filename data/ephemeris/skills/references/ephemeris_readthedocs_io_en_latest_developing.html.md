[Ephemeris](index.html)

* [Introduction](readme.html)
* [Installation](installation.html)
* [Commands](commands.html)
* [Code of conduct](conduct.html)
* [Contributing](contributing.html)
* [Project Governance](organization.html)
* Release Checklist
* [History](history.html)

[Ephemeris](index.html)

* Release Checklist
* [View page source](_sources/developing.rst.txt)

---

# Release Checklist[¶](#release-checklist "Link to this heading")

This page describes the process of releasing new versions of Ephemeris.

This release checklist is based on the [Pocoo Release Management Workflow](http://www.pocoo.org/internal/release-management/).

This assumes `~/.pypirc` file exists with the following fields (variations)
are fine.

```
[pypi]
username:<username>
password:<password>

[test]
repository:https://testpypi.python.org/pypi
username:<username>
password:<password>
```

* Review `git status` for missing files.
* Verify the latest Travis CI builds pass.
* `make open-docs` and review changelog.
* Ensure the target release is set correctly in `src/ephemeris/__init__.py` (
  `version` will be a `devN` variant of target release).
* `make clean && make lint && make test`
* `make release`

  This process will push packages to test PyPI, allow review, publish
  to production PyPI, tag the git repository, push the tag upstream.
  If custom changes to this process are needed, the process can be
  broken down into steps including:

  + `make release-local`
  + `make push-release`

[Previous](organization.html "Project Governance")
[Next](history.html "History")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).