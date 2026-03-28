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
  + [Workflow-install](workflow-install.html)
  + Workflow-to-tools
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.generate_tool_list_from_ga_workflow_files-_parser-named-arguments)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Workflow-to-tools
* [View page source](../_sources/commands/workflow-to-tools.rst.txt)

---

# Workflow-to-tools[¶](#module-ephemeris.generate_tool_list_from_ga_workflow_files "Link to this heading")

Tool to generate tools from workflows

## Usage[¶](#usage "Link to this heading")

```
usage: workflow-to-tools <options>
```

### Named Arguments[¶](#ephemeris.generate_tool_list_from_ga_workflow_files-_parser-named-arguments "Link to this heading")

`-w, --workflow`
:   A space separated list of galaxy workflow description files in json format

`-o, --output-file`
:   The output file with a yml tool list

`-l, --panel-label, --panel_label`
:   The name of the panel where the tools will show up in Galaxy.If not specified: “Tools from workflows”

    Default: `'Tools from workflows'`

`-j, --json-panel-label-suggestion, --json_panel_label_suggestion`
:   File path or URL with a json with the default panel\_label. For example ‘<https://training.galaxyproject.org/api/toolcats.json>’

Workflow files must have been exported from Galaxy release 16.04 or newer.

example:
python %(prog)s -w workflow1 workflow2 -o mytool\_list.yml -l my\_panel\_label
Christophe Antoniewski <drosofff@gmail.com>
<https://github.com/ARTbio/ansible-artimed/tree/master/extra-files/generate_tool_list_from_ga_workflow_files.py>

[Previous](workflow-install.html "Workflow-install")
[Next](../conduct.html "Code of conduct")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).