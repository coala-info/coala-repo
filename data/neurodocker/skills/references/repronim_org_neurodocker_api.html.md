[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[Neurodocker documentation](index.html)

* [User Guide](user_guide/index.html)
* API Reference

Search
`Ctrl`+`K`

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Search
`Ctrl`+`K`

* [User Guide](user_guide/index.html)
* API Reference

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Section Navigation

* [neurodocker package](api/neurodocker.html)
  + [neurodocker.reproenv package](api/neurodocker.reproenv.html)
    - [neurodocker.reproenv.exceptions module](api/neurodocker.reproenv.exceptions.html)
    - [neurodocker.reproenv.renderers module](api/neurodocker.reproenv.renderers.html)
    - [neurodocker.reproenv.state module](api/neurodocker.reproenv.state.html)
    - [neurodocker.reproenv.template module](api/neurodocker.reproenv.template.html)
    - [neurodocker.reproenv.types module](api/neurodocker.reproenv.types.html)

* API Reference

# API Reference[#](#module-neurodocker "Permalink to this heading")

Neurodocker generates containers for neuroimaging.

It includes ReproEnv, which is an extensible, generic container generator.

## Subpackages[#](#subpackages "Permalink to this heading")

* [neurodocker package](api/neurodocker.html)
  + [Subpackages](api/neurodocker.html#subpackages)
    - [neurodocker.reproenv package](api/neurodocker.reproenv.html)
      * [Submodules](api/neurodocker.reproenv.html#submodules)
        + [neurodocker.reproenv.exceptions module](api/neurodocker.reproenv.exceptions.html)
          - [`RendererError`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.RendererError)
          - [`ReproEnvError`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.ReproEnvError)
          - [`RequirementsError`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.RequirementsError)
          - [`TemplateError`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.TemplateError)
          - [`TemplateKeywordArgumentError`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.TemplateKeywordArgumentError)
          - [`TemplateNotFound`](api/neurodocker.reproenv.exceptions.html#neurodocker.reproenv.exceptions.TemplateNotFound)
        + [neurodocker.reproenv.renderers module](api/neurodocker.reproenv.renderers.html)
          - [`DockerRenderer`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer)
            * [`DockerRenderer.add()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.add)
            * [`DockerRenderer.arg()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.arg)
            * [`DockerRenderer.copy()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.copy)
            * [`DockerRenderer.entrypoint()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.entrypoint)
            * [`DockerRenderer.env()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.env)
            * [`DockerRenderer.from_()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.from_)
            * [`DockerRenderer.install()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.install)
            * [`DockerRenderer.label()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.label)
            * [`DockerRenderer.render()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.render)
            * [`DockerRenderer.run()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.run)
            * [`DockerRenderer.user()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.user)
            * [`DockerRenderer.workdir()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.DockerRenderer.workdir)
          - [`SingularityRenderer`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer)
            * [`SingularityRenderer.arg()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.arg)
            * [`SingularityRenderer.copy()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.copy)
            * [`SingularityRenderer.entrypoint()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.entrypoint)
            * [`SingularityRenderer.env()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.env)
            * [`SingularityRenderer.from_()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.from_)
            * [`SingularityRenderer.install()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.install)
            * [`SingularityRenderer.label()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.label)
            * [`SingularityRenderer.render()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.render)
            * [`SingularityRenderer.run()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.run)
            * [`SingularityRenderer.user()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.user)
            * [`SingularityRenderer.workdir()`](api/neurodocker.reproenv.renderers.html#neurodocker.reproenv.renderers.SingularityRenderer.workdir)
        + [neurodocker.reproenv.state module](api/neurodocker.reproenv.state.html)
          - [`get_template()`](api/neurodocker.reproenv.state.html#neurodocker.reproenv.state.get_template)
          - [`register_template()`](api/neurodocker.reproenv.state.html#neurodocker.reproenv.state.register_template)
          - [`registered_templates()`](api/neurodocker.reproenv.state.html#neurodocker.reproenv.state.registered_templates)
          - [`registered_templates_items()`](api/neurodocker.reproenv.state.html#neurodocker.reproenv.state.registered_templates_items)
        + [neurodocker.reproenv.template module](api/neurodocker.reproenv.template.html)
          - [`Template`](api/neurodocker.reproenv.template.html#neurodocker.reproenv.template.Template)
            * [`Template.alert`](api/neurodocker.reproenv.template.html#neurodocker.reproenv.template.Template.alert)
            * [`Template.binaries`](api/neurodocker.reproenv.template.html#neurodocker.reproenv.template.Template.binaries)
            * [`Template.name`](api/neurodocker.reproenv.template.html#neurodocker.reproenv.template.Template.name)
            * [`Template.source`](api/neurodocker.reproenv.template.html#neurodocker.reproenv.template.Template.source)
        + [neurodocker.reproenv.types module](api/neurodocker.reproenv.types.html)
          - [`TemplateType`](api/neurodocker.reproenv.types.html#neurodocker.reproenv.types.TemplateType)
            * [`TemplateType.alert`](api/neurodocker.reproenv.types.html#neurodocker.reproenv.types.TemplateType.alert)
            * [`TemplateType.binaries`](api/neurodocker.reproenv.types.html#neurodocker.reproenv.types.TemplateType.binaries)
            * [`TemplateType.name`](api/neurodocker.reproenv.types.html#neurodocker.reproenv.types.TemplateType.name)
            * [`TemplateType.source`](api/neurodocker.reproenv.types.html#neurodocker.reproenv.types.TemplateType.source)

[previous

Known Issues](user_guide/known_issues.html "previous page")
[next

neurodocker package](api/neurodocker.html "next page")

On this page

* [Subpackages](#subpackages)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/api.rst)

### This Page

* [Show Source](_sources/api.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.