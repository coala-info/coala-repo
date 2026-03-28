[genomepy](../index.html)

* [Home](../index.html)
* [Installation](installation.html)
* [Command line documentation](command_line.html)
* [Python API documentation (core)](api_core.html)
* [Python API documentation (full)](../_autosummary/genomepy.html)
* Configuration
  + [Configurable options](#configurable-options)
* [FAQ](help_faq.html)
* [About](about.html)

[genomepy](../index.html)

* Configuration
* [Edit on GitHub](https://github.com/vanheeringen-lab/genomepy/blob/develop/docs/content/config.rst)

---

# Configuration[](#configuration "Permalink to this heading")

Genomepy uses many configurable options.
The default setting for several options can be overwritten using a config file.

You can create new config file with `genomepy config generate`,
or find the location of your current config file with `genomepy config file`.

## Configurable options[](#configurable-options "Permalink to this heading")

The config file uses the YAML format, wherein each configurable option is given as a `key: value` pair,
and anything after the comment symbol `#` is ignored.

These keys are currently supported:

* `bgzip`: determines if newly installed assembly data is compressed or not.

  > + Options: `true` or `false`.
  > + Default: `false`
* `cache_exp_genomes`: expiration time (in seconds) for the cache used in `genomepy search`.
  (Re)building this cache is slow, but must be done periodically to get the latest assemblies.
  This setting does not affect your installed assembly data.

  > + Options: an integer or scientific number, or `None` for infinite.
  > + Default: 6.048e5 (1 week)
* `cache_exp_other`: expiration time (in seconds) for the cache used in short term activities (e.g. mygene.info queries).
  This setting does not affect your installed assembly data.

  > + Options: an integer or scientific number, or `None` for infinite.
  > + Default: 3.6e3 (1 hour)
* `genomes_dir`: the path where assembly data will be installed.

  > + Default: `~/.local/share/genomes/`
* `plugin`: the list of currently active plugins.
  See command `genomepy plugin show` for options.
  `genomepy plugin` can also be used to easily change this list.

[Previous](../_autosummary/genomepy.utils.try_except_pass.html "genomepy.utils.try_except_pass")
[Next](help_faq.html "Frequently Asked Questions")

---

© Copyright Siebren Frölich, Maarten van der Sande, Tilman Schäfers and Simon van Heeringen.
Last updated on 2025-09-30, 12:32 (UTC).

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).