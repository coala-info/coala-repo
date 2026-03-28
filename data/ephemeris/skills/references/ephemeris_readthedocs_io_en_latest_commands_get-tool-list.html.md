[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + Get-tool-list
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.get_tool_list_from_galaxy-_parser-named-arguments)
      * [General options](#ephemeris.get_tool_list_from_galaxy-_parser-general-options)
      * [Galaxy connection](#ephemeris.get_tool_list_from_galaxy-_parser-galaxy-connection)
  + [Run-data-managers](run-data-managers.html)
  + [Setup-data-libraries](setup-data-libraries.html)
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
* Get-tool-list
* [View page source](../_sources/commands/get-tool-list.rst.txt)

---

# Get-tool-list[¶](#module-ephemeris.get_tool_list_from_galaxy "Link to this heading")

Tool to extract a tool list from galaxy.

## Usage[¶](#usage "Link to this heading")

```
usage: get-tool-list [-h] [-v] [-g GALAXY] [-u USER] [-p PASSWORD]
                     [-a API_KEY] -o OUTPUT [--include-tool-panel-id]
                     [--skip-tool-panel-name] [--skip-changeset-revision]
                     [--get-data-managers] [--get-all-tools]
```

### Named Arguments[¶](#ephemeris.get_tool_list_from_galaxy-_parser-named-arguments "Link to this heading")

`-o, --output-file`
:   tool\_list.yml output file

`--include-tool-panel-id, --include_tool_panel_id`
:   Include tool\_panel\_id in tool\_list.yml ? Use this only if the tool panel id already exists. See <https://github.com/galaxyproject/ansible-galaxy-tools/blob/master/files/tool_list.yaml.sample>

    Default: `False`

`--skip-tool-panel-name, --skip_tool_panel_name`
:   Do not include tool\_panel\_name in tool\_list.yml ?

    Default: `False`

`--skip-changeset-revision, --skip_changeset_revision`
:   Do not include the changeset revision when generating the tool list.Use this if you would like to use the list to update all the tools inyour galaxy instance using shed-install.

    Default: `False`

`--get-data-managers, --get_data_managers`
:   Include the data managers in the tool list. Requires admin login details

    Default: `False`

`--get-all-tools, --get_all_tools`
:   Get all tools and revisions, not just those which are present on the web ui.Requires login details.

    Default: `False`

### General options[¶](#ephemeris.get_tool_list_from_galaxy-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

### Galaxy connection[¶](#ephemeris.get_tool_list_from_galaxy-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

[Previous](galaxy-wait.html "Galaxy-wait")
[Next](run-data-managers.html "Run-data-managers")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).