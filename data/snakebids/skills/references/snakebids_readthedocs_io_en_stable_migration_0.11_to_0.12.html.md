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
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](index.html)[x]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/migration/0.11_to_0.12.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/migration/0.11_to_0.12.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# 0.11 to 0.12+[¶](#to-0-12 "Link to this heading")

Snakebids 0.12 introduces a [new, more flexible module](../api/app.html#module-snakebids.bidsapp "snakebids.bidsapp") for creating bidsapps. This affects the syntax of the `run.py` file. Older versions used the [`snakebids.app.SnakeBidsApp`](../api/app.html#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp") class to initialize the bidsapp, and this method will still work for the foreseeable future. Switching to the new syntax will give access to new plugins and integrations and ensure long term support.

If you haven’t heavily modified your `run.py` file, you can transition simply by replacing it with the following:

```
 1#!/usr/bin/env python3
 2from pathlib import Path
 3
 4from snakebids import bidsapp, plugins
 5
 6app = bidsapp.app(
 7    [
 8        plugins.SnakemakeBidsApp(Path(__file__).resolve().parent),
 9        plugins.BidsValidator(),
10        plugins.Version(distribution="<app_name_here>"),
11    ]
12)
13
14
15def get_parser():
16    """Exposes parser for sphinx doc generation, cwd is the docs dir."""
17    return app.build_parser().parser
18
19
20if __name__ == "__main__":
21    app.run()
```

The snakemake workflow will work in exactly the same way.

[Next

API](../api/main.html)
[Previous

0.7 to 0.8+](0.7_to_0.8.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)