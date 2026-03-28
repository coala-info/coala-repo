[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + [Get-tool-list](get-tool-list.html)
  + [Run-data-managers](run-data-managers.html)
  + Setup-data-libraries
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.setup_data_libraries-_parser-named-arguments)
      * [General options](#ephemeris.setup_data_libraries-_parser-general-options)
      * [Galaxy connection](#ephemeris.setup_data_libraries-_parser-galaxy-connection)
  + [Shed-tools](shed-tools.html)
  + [Install-tool-deps](install-tool-deps.html)
  + [Workflow-install](workflow-install.html)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Setup-data-libraries
* [View page source](../_sources/commands/setup-data-libraries.rst.txt)

---

# Setup-data-libraries[¶](#module-ephemeris.setup_data_libraries "Link to this heading")

Tool to setup data libraries on a galaxy instance

## Usage[¶](#usage "Link to this heading")

Populate the Galaxy data library with data.

```
usage: setup-data-libraries [-h] [-v] [-g GALAXY] [-u USER] [-p PASSWORD]
                            [-a API_KEY] -i INFILE [--training] [--legacy]
```

### Named Arguments[¶](#ephemeris.setup_data_libraries-_parser-named-arguments "Link to this heading")

`-i, --infile`

`--training`
:   Set defaults that make sense for training data.

    Default: `False`

`--legacy`
:   Use legacy APIs even for newer Galaxies that should have a batch upload API enabled.

    Default: `False`

### General options[¶](#ephemeris.setup_data_libraries-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

### Galaxy connection[¶](#ephemeris.setup_data_libraries-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

[Previous](run-data-managers.html "Run-data-managers")
[Next](shed-tools.html "Shed-tools")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).