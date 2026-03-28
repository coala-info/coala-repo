[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[Neurodocker documentation](../index.html)

* [User Guide](index.html)
* [API Reference](../api.html)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Search
`Ctrl`+`K`

* [User Guide](index.html)
* [API Reference](../api.html)

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Section Navigation

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [Command-line Interface](cli.html)
* [Examples](examples.html)
* [Common Uses](common_uses.html)
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* Add software to Neurodocker
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Add software to Neurodocker

# Add software to Neurodocker[#](#add-software-to-neurodocker "Permalink to this heading")

Neurodocker defines the instructions to install and configure software using YAML files.
These files are known as *templates*. This page explains how to add a new template to
Neurodocker.

The `env` and `instructions` values can use
[Jinja2](https://jinja.palletsprojects.com/en/2.11.x/templates/) template language.

## Example specification[#](#example-specification "Permalink to this heading")

This example installs `jq`, a
[command-line JSON processor](https://github.com/stedolan/jq).

```
# The name of the software. This becomes the name in the template registry.
# The CLI option would be rendered as `--jq`.
name: jq
url: https://jqlang.github.io/jq/
# An alert that is printed when using this template in the CLI.
alert: Please be advised that this software uses
# How to install this software from pre-compiled binaries.
binaries:
  # The available versions and their corresponding urls.
  urls:
    "1.6": https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
    "1.5": https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  # Arguments that the user can provide when using this template. These arguments
  # should be referenced in the `env` and/or `instructions`.
  arguments:
    required:
    - version
    optional:
      install_path: /opt/jq-{{ self.version }}
  # Environment variables to set in the container. Keys and values must be strings.
  env:
    PATH: {{ self.install_path }}:$PATH
  # System packages that this software depends on.
  dependencies:
    apt:
    - ca-certificates
    - curl
    yum:
    - curl
  # The installation instructions. Think of this like a shell scripts that installs
  # the software.
  instructions: |
    {{ self.install_dependencies() }}
    mkdir -p {{ self.install_path }}
    curl -fsSL --output {{ self.install_path }}/jq {{ self.urls[self.version]}}
    chmod +x {{ self.install_path }}/jq
```

[previous

Templates and Renderers](templates_renderers.html "previous page")
[next

Known Issues](known_issues.html "next page")

On this page

* [Example specification](#example-specification)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/add_template.rst)

### This Page

* [Show Source](../_sources/user_guide/add_template.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.