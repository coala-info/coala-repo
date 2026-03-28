[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + [Get-tool-list](get-tool-list.html)
  + [Run-data-managers](run-data-managers.html)
  + [Setup-data-libraries](setup-data-libraries.html)
  + [Shed-tools](shed-tools.html)
  + Install-tool-deps
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.install_tool_deps-_parser-named-arguments)
      * [General options](#ephemeris.install_tool_deps-_parser-general-options)
      * [Galaxy connection](#ephemeris.install_tool_deps-_parser-galaxy-connection)
  + [Workflow-install](workflow-install.html)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Install-tool-deps
* [View page source](../_sources/commands/install-tool-deps.rst.txt)

---

# Install-tool-deps[¶](#module-ephemeris.install_tool_deps "Link to this heading")

Tool to install tool dependencies on a Galaxy instance.

## Usage[¶](#usage "Link to this heading")

```
usage: install-tool-deps [-h] [-v] [-g GALAXY] [-u USER] [-p PASSWORD]
                         [-a API_KEY] [-t [TOOL ...]] [-i [ID ...]]
```

### Named Arguments[¶](#ephemeris.install_tool_deps-_parser-named-arguments "Link to this heading")

`-t, --tool`
:   Path to a tool file, tool\_conf file, or yaml file containing a sequence of tool ids

`-i, --id`
:   Space-separated list of tool ids

### General options[¶](#ephemeris.install_tool_deps-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

### Galaxy connection[¶](#ephemeris.install_tool_deps-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

[Previous](shed-tools.html "Shed-tools")
[Next](workflow-install.html "Workflow-install")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).