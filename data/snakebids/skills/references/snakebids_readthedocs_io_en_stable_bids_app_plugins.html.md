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
* [Bids Apps](overview.html)[x]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/bids_app/plugins.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/bids_app/plugins.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Plugins[¶](#plugins "Link to this heading")

Plugins allow you to extend the functionality of your [BIDS app](../api/app.html#module-snakebids.bidsapp "snakebids.bidsapp") before and after parsing CLI arguments. For example, you can use a plugin to perform BIDS validation of your Snakebids app’s input, which ensures your app is only executed if the input dataset is valid. You can either use those that are distributed with Snakebids (see [Using plugins](#using-plugins)) or create your own plugins (see [Creating plugins](#creating-plugins)).

Note

For a full list of plugins distributed with Snakebids, see the [Plugins reference](../api/plugins.html) page.

Nearly all of the functionality provided by [`snakebids.bidsapp`](../api/app.html#module-snakebids.bidsapp "snakebids.bidsapp") is provided by plugins, including [`SnakemakeBidsApp`](../api/plugins.html#snakebids.plugins.SnakemakeBidsApp "snakebids.plugins.snakemake.SnakemakeBidsApp").

Unlike in libraries such as pytest, plugins must be explicitly enabled to be included in the app. Installing them with pip is not enough! This affords a great deal of control over how the BIDS app is executed.

## Using plugins[¶](#using-plugins "Link to this heading")

To add plugins to your [`bidsapp`](../api/app.html#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp"), pass them to the [`SnakeBidsApp`](../api/app.html#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp") constructor via the `plugins` parameter. Plugins are executed in LIFO order (last in, first out).

As an example, the [`BidsValidator`](../api/plugins.html#snakebids.plugins.BidsValidator "snakebids.plugins.BidsValidator") plugin can be used to run the [BIDS Validator](https://github.com/bids-standard/bids-validator) on the input directory like so:

```
1from snakebids import bidsapp, plugins
2
3bidsapp.app([
4    plugins.SnakemakeBidsApp("path/to/snakebids/app"),
5    plugins.BidsValidator,
6]).run()
```

### Dependencies[¶](#dependencies "Link to this heading")

Some plugins depend on other plugins. These dependencies will be loaded even if not specified in [`bidsapp.app`](../api/app.html#snakebids.bidsapp.app "snakebids.bidsapp.app"). If a dependency needs explicit configuration, however, they may still be safely provided in app initialization, as snakebids will prevent duplicate registration.

For example, [`SnakemakeBidsApp`](../api/plugins.html#snakebids.plugins.SnakemakeBidsApp "snakebids.plugins.SnakemakeBidsApp") depends on [`BidsArgs`](../api/plugins.html#snakebids.plugins.BidsArgs "snakebids.plugins.BidsArgs"), [`CliConfig`](../api/plugins.html#snakebids.plugins.CliConfig "snakebids.plugins.CliConfig"), [`ComponentEdit`](../api/plugins.html#snakebids.plugins.ComponentEdit "snakebids.plugins.ComponentEdit"), etc, but these plugins may still be specified to change their configuration. The order of specification will be respected (e.g. [LIFO](https://pluggy.readthedocs.io/en/stable/index.html#callorder "pluggy 0.1")).

```
1from snakebids import bidsapp, plugins
2
3bidsapp.app([
4    plugins.SnakemakeBidsApp("path/to/snakebids/app"),
5    # specify the BidsArgs plugin to override the argument group
6    plugins.BidsArgs(argument_group="MAIN"),
7]).run()
```

## Creating plugins[¶](#creating-plugins "Link to this heading")

Plugins are implemented using [`pluggy`](https://pluggy.readthedocs.io/en/stable/index.html "pluggy 0.1"), the plugin system used and maintained by pytest. Actions are executed in one of several hooks. These are called at specified times as the argument parser is built, arguments are parsed, and the config is formatted.

A plugin is a class or module with methods or functions wrapped with the snakebids plugin hook decorator: [`snakebids.bidsapp.hookimpl`](../api/plugins.html#snakebids.plugins.snakebids.bidsapp.hookimpl "snakebids.plugins.snakebids.bidsapp.hookimpl"). The name of the function determines the stage of app initialization at which it will be called. Each recognized function name (known as specs) comes with a specified set of available arguments. Not all the available arguments need to be used, however, they must be given the correct name. The [API documentation](../api/plugins.html#snakebids.plugins.snakebids.bidsapp.hookimpl "snakebids.plugins.snakebids.bidsapp.hookimpl") contains the complete list of available specs, their corresponding initialization stages, and the arguments they can access.

As an example, a simplified version of the bids-validator plugin that runs the [BIDS Validator](https://github.com/bids-standard/bids-validator) could be defined as follows:

```
 1import argparse
 2import subprocess
 3from typing import Any
 4
 5from snakebids import bidsapp
 6
 7class BidsValidator:
 8    """Perform BIDS validation of dataset
 9
10    Parameters
11    -----------
12    app
13        Snakebids application to be run
14    """
15
16    @bidsapp.hookimpl
17    def add_cli_arguments(self, parser: argparse.ArgumentParser):
18        parser.add_argument("--skip-validation", dest="plugins.validator.skip")
19
20    @bidsapp.hookimpl
21    def finalize_config(self, config: dict[str, Any]) -> None:
22        # Skip bids validation
23        if config["plugins.validator.skip"]:
24            return
25
26        try:
27            subprocess.run(
28                ["bids-validator", config["bids_dir"]], check=True
29            )
30        except subprocess.CalledProcessError as err:
31            raise InvalidBidsError from err
32
33
34class InvalidBidsError(SnakebidsPluginError):
35    """Error raised if input BIDS dataset is invalid,
36    inheriting from SnakebidsPluginError.
37    """
```

In this example, two hooks were used. The [`add_cli_arguments()`](../api/plugins.html#snakebids.bidsapp.hookspecs.add_cli_arguments "snakebids.bidsapp.hookspecs.add_cli_arguments") hook is called before CLI arguments are parsed. Here, it adds an argument allowing end users of our app to skip bids validation. Note that the [spec](../api/plugins.html#snakebids.bidsapp.hookspecs.add_cli_arguments "snakebids.bidsapp.hookspecs.add_cli_arguments") specifies three arguments available to this hook (`parser`, `config`, and `argument_groups`), however, we only used `parser` here.

Note

When adding plugin-specific parameters to the config dictionary, it is recommended to use namespaced keys (e.g. `plugins.validator.skip`). This will help ensure plugin-specific parameters do not conflict with other parameters already defined in the dictionary or by other plugins.

The [`finalize_config()`](../api/plugins.html#snakebids.bidsapp.hookspecs.finalize_config "snakebids.bidsapp.hookspecs.finalize_config") hook is called after `config` is updated with the results of argument parsing. In our plugin, this is where validation is actually performed. Note how the argument added in the previous hook is now read from `config`. Any modifications made to `config` will be carried forward into the app’s remaining lifetime.

A plugin can be used to implement any logic that can be handled by a Python function. In the above example, you may also want to add some logic to check if the BIDS Validator is installed and pass along a custom error message if it is not. Created plugins can then be used within a Snakebids workflow, similar to the example provided in [Using plugins](#using-plugins) section. Prospective plugin developers can take a look at the source of the `snakebids.plugins` module for examples.

Note

When creating a custom error for your Snakebids plugin, it is recommended to inherit from [`SnakebidsPluginError`](../api/internals.html#snakebids.exceptions.SnakebidsPluginError "snakebids.exceptions.SnakebidsPluginError") such that errors will be recognized as a plugin error.

### Specifying dependencies[¶](#specifying-dependencies "Link to this heading")

[Dependencies](#dependencies) may be specified using a `DEPENDENCIES` attribute in your plugin class or module. It should be set to a tuple containing fully initialized plugin references. These dependencies will be registered after the depending plugin and therefore run first (due to pluggy’s [LIFO order](https://pluggy.readthedocs.io/en/stable/index.html#callorder "pluggy 0.1")).

```
 1from snakebids import bidsapp, plugins
 2
 3class MyPlugin:
 4    DEPENDENCIES = (
 5        plugins.CliConfig(),
 6        plugins.BidsArgs(),
 7    )
 8
 9    @bidsapp.hookimpl
10    def finalize_config(self, config):
11        ...
```

[Next

Running Snakebids](../running_snakebids/overview.html)
[Previous

Workflows](workflow.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Plugins
  + [Using plugins](#using-plugins)
    - [Dependencies](#dependencies)
  + [Creating plugins](#creating-plugins)
    - [Specifying dependencies](#specifying-dependencies)