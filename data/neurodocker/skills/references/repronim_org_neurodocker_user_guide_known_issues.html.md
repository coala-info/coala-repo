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
* [Add software to Neurodocker](add_template.html)
* Known Issues

* [User Guide](index.html)
* Known Issues

# Known Issues[#](#known-issues "Permalink to this heading")

* Using the `-t/--tty` option in `docker run` produces non-printable
  characters in the generated Dockerfile or Singularity recipe
  (see [moby/moby#8513](https://github.com/moby/moby/issues/8513#issuecomment-216191236)).

  + Solution: do not use the `-t/--tty` flag, unless using the container interactively.
* Attempting to rebuild into an existing Singularity image may raise an error.

  + Solution: remove the existing image or build a new image file.
* The default apt `--install` option `--no-install-recommends`
  (that aims to minimize container size) can cause unexpected behavior.

  + Solution: use `--install opts="--quiet" package1 package2`
* FreeSurfer cannot find my license file.

  + Solution: get a free license from
    [FreeSurfer’s website](https://surfer.nmr.mgh.harvard.edu/registration.html), and
    copy it into the container. To build the Docker image, please use the form

    > ```
    > docker build .
    > ```

    instead of

    > ```
    > docker build - < Dockerfile
    > ```

    because the latter form will not copy files into the image.

[previous

Add software to Neurodocker](add_template.html "previous page")
[next

API Reference](../api.html "next page")

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/known_issues.rst)

### This Page

* [Show Source](../_sources/user_guide/known_issues.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.