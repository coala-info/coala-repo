Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* Bids Apps[x]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/bids_app/overview.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/bids_app/overview.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Bids Apps[¶](#bids-apps "Link to this heading")

Snakebids apps rely on a configuration file (`snakebids.yml`). This file specifies which files from a BIDS dataset should be used as input. The apps also utilize workflow definitions, which are written in one or more Snakefile(s) and determine how the input files are processed.

Note

For an easy setup of new Snakebids apps with convenient command-line functions, we recommend installing Snakebids using `pipx`. Visit the [following page](https://pypa.github.io/pipx/) for instructions on how to install `pipx`.

Once Snakebids is installed, you can generate a customized Snakebids project by running the command `snakebids create` and providing the necessary information when prompted.

[Next

Configuration](config.html)
[Previous

Bids Function](../bids_function/overview.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)