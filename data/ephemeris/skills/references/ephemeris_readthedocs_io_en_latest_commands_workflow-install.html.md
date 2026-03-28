[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + [Get-tool-list](get-tool-list.html)
  + [Run-data-managers](run-data-managers.html)
  + [Setup-data-libraries](setup-data-libraries.html)
  + [Shed-tools](shed-tools.html)
  + [Install-tool-deps](install-tool-deps.html)
  + Workflow-install
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.workflow_install-_parser-named-arguments)
      * [General options](#ephemeris.workflow_install-_parser-general-options)
      * [Galaxy connection](#ephemeris.workflow_install-_parser-galaxy-connection)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Workflow-install
* [View page source](../_sources/commands/workflow-install.rst.txt)

---

# Workflow-install[¶](#module-ephemeris.workflow_install "Link to this heading")

Tool to install workflows on a Galaxy instance.

## Usage[¶](#usage "Link to this heading")

```
usage: workflow-install [-h] [-v] [-g GALAXY] [-u USER] [-p PASSWORD]
                        [-a API_KEY] -w WORKFLOW_PATH [--publish-workflows]
```

### Named Arguments[¶](#ephemeris.workflow_install-_parser-named-arguments "Link to this heading")

`-w, --workflow-path, --workflow_path`
:   Path to a workflow file or a directory with multiple workflow files ending with “.ga”

`--publish-workflows, --publish_workflows`
:   Flag to publish all imported workflows, so that they are viewable by other users

    Default: `False`

### General options[¶](#ephemeris.workflow_install-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

### Galaxy connection[¶](#ephemeris.workflow_install-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

[Previous](install-tool-deps.html "Install-tool-deps")
[Next](workflow-to-tools.html "Workflow-to-tools")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).