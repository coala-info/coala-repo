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
* [Migrations](../migration/index.html)[ ]

Reference

* [API](main.html)[x]
* [Internals](internals.html)
* [Plugins](plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/app.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/app.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# BIDS App Bootstrapping[¶](#module-snakebids.app "Link to this heading")

Tools to generate a Snakemake-based BIDS app.

This legacy module once had the core snakebids bidsapp implementation, but now is a
simple wrapper around [`snakebids.bidsapp`](#module-snakebids.bidsapp "snakebids.bidsapp") with the
[`SnakemakeBidsApp`](plugins.html#snakebids.plugins.SnakemakeBidsApp "snakebids.plugins.SnakemakeBidsApp") plugin. For new apps, this functionality
can be more flexibly implemented with:

```
from snakebids import bidsapp, plugins

bidsapp.app([plugins.SnakemakeBidsApp(...)])
```

*class* snakebids.app.SnakeBidsApp(*snakemake\_dir*, *plugins=NOTHING*, *skip\_parse\_args=False*, *parser=None*, *configfile\_path=None*, *snakefile\_path=None*, *config=None*, *version=None*, *args=None*)[¶](#snakebids.app.SnakeBidsApp "Link to this definition")
:   Snakebids app with config and arguments.

    Parameters:
    :   * **snakemake\_dir** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *Path*) – Root directory of the snakebids app, containing the config file and workflow
          files.
        * **plugins** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")*[*[*collections.abc.Callable*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Callable "(in Python v3.14)")*[**[*[*SnakeBidsApp*](#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp")*]**,* *None* *|* [*SnakeBidsApp*](#snakebids.app.SnakeBidsApp "snakebids.app.SnakeBidsApp")*]**]*) –

          List of plugins to be registered.

          See [Using plugins](../bids_app/plugins.html#using-plugins) for more info.
        * **skip\_parse\_args** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – DEPRECATED: no-op.
        * **parser** (*Any*) – DEPRECATED: no-op. (Historic: Parser including only the arguments
          specific to this Snakebids app, as specified in the config file. By
          default, it will use create\_parser() from cli.py)
        * **configfile\_path** ([*pathlib.Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Relative path to config file (relative to snakemake\_dir). By default,
          autocalculates based on snamake\_dir
        * **snakefile\_path** ([*pathlib.Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) –

          Absolute path to the input Snakefile. By default, autocalculates based on
          snakemake\_dir:

          ```
          join(snakemake_dir, snakefile_path)
          ```
        * **config** (*Any*) – DEPRECATED: no-op. (Historic: Contains all the configuration variables
          parsed from the config file and generated during the initialization of
          the SnakeBidsApp.)
        * **args** (*Any*) – DEPRECATED: no-op. (Historic: Arguments to use when running the app. By
          default, generated using the parser attribute, autopopulated with args
          from config.py)
        * **version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – DEPRECATED: no-op, use version plugin instead

    *property* config[¶](#snakebids.app.SnakeBidsApp.config "Link to this definition")
    :   Get config dict (before arguments are parsed).

    *property* parser[¶](#snakebids.app.SnakeBidsApp.parser "Link to this definition")
    :   Get parser.

    run\_snakemake()[¶](#snakebids.app.SnakeBidsApp.run_snakemake "Link to this definition")
    :   Run snakemake with the given config, after applying plugins.

        Return type:
        :   None

    create\_descriptor(*out\_file*)[¶](#snakebids.app.SnakeBidsApp.create_descriptor "Link to this definition")
    :   Generate a boutiques descriptor for this Snakebids app.

        Parameters:
        :   **out\_file** ([*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

        Return type:
        :   None

## BIDS App[¶](#module-snakebids.bidsapp "Link to this heading")

snakebids.bidsapp.app(*plugins=None*, *\**, *config=None*, *\*\*argparse\_args*)[¶](#snakebids.bidsapp.app "Link to this definition")
:   Create a BIDSApp.

    Parameters:
    :   * **plugins** (*Iterable**[**\_Plugin**]* *|* *None*) – List of snakebids plugins to apply to app (see [Using plugins](../bids_app/plugins.html#using-plugins)).
        * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *Any**]* *|* *None*) – Initial config. Will be updated with parsed arguments from `parser` and
          potentially modified by plugins
        * **\*\*argparse\_args** (*Unpack**[**ArgumentParserArgs**]*) – Arguments passed on transparently to [`argparse.ArgumentParser`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)").

    Return type:
    :   [\_Runner](#snakebids.bidsapp.run._Runner "snakebids.bidsapp.run._Runner")

*class* snakebids.bidsapp.run.\_Runner[¶](#snakebids.bidsapp.run._Runner "Link to this definition")
:   Runtime manager for BIDS apps.

    Manages the parser, config, and plugin relay for snakebids BIDS apps. This class
    should not be constructed directly, but built using the
    [`bidsapp.app()`](#snakebids.bidsapp.app "snakebids.bidsapp.app") function.

    Parameters:
    :   * **pm** ([*pluggy.PluginManager*](https://pluggy.readthedocs.io/en/stable/api_reference.html#pluggy.PluginManager "(in pluggy v0.1)"))
        * **parser** ([*argparse.ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)"))
        * **argument\_groups** (*ArgumentGroups*)

    pm*: [pluggy.PluginManager](https://pluggy.readthedocs.io/en/stable/api_reference.html#pluggy.PluginManager "(in pluggy v0.1)")*[¶](#snakebids.bidsapp.run._Runner.pm "Link to this definition")
    :   Reference to the plugin manager.

    parser*: [argparse.ArgumentParser](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)")*[¶](#snakebids.bidsapp.run._Runner.parser "Link to this definition")
    :   Parser used for parsing CLI arguments.

        The parser may be manipulated before running action methods to add initial arguments
        (via [`parser.add_argument()`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument "(in Python v3.14)")) and
        argument groups (via [`parser.add_argument_group()`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument_group "(in Python v3.14)")). Any argument groups added will
        automatically be indexed in [`argument_groups`](#snakebids.bidsapp.run._Runner.argument_groups "snakebids.bidsapp.run._Runner.argument_groups") and made available to plugins
        via their `title`.

    config*: [dict](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"), Any]*[¶](#snakebids.bidsapp.run._Runner.config "Link to this definition")
    :   Configuration dictionary for passing data between plugins.

    argument\_groups*: ArgumentGroups*[¶](#snakebids.bidsapp.run._Runner.argument_groups "Link to this definition")
    :   Argument group reference accessible to plugins for organizing CLI arguments.

        Any groups added to the [`parser`](#snakebids.bidsapp.run._Runner.parser "snakebids.bidsapp.run._Runner.parser") before the action methods are called will
        be automatically added, indexed by their titles. Thus, this object should typically
        only be used within plugins.

    ### Action Methods[¶](#action-methods "Link to this heading")

    Plugins are only run when calling the action methods. These methods trigger
    running of the plugins up to a specified point. For example,
    [`build_parser()`](#snakebids.bidsapp.run._Runner.build_parser "snakebids.bidsapp.run._Runner.build_parser") runs the `initialize_config()`
    and `add_cli_arguments()` hooks. It can thus be used to build
    the parser without actually parsing any arguments.

    Plugins are always run in the same order. Action methods will always trigger
    the entire plugin chain up until their stopping point. Importantly, plugins
    will only ever be run once, even if action methods are called multiple
    times. For example, if [`build_parser()`](#snakebids.bidsapp.run._Runner.build_parser "snakebids.bidsapp.run._Runner.build_parser") is called, then
    [`parse_args()`](#snakebids.bidsapp.run._Runner.parse_args "snakebids.bidsapp.run._Runner.parse_args"), the parser will only be built once.

    build\_parser()[¶](#snakebids.bidsapp.run._Runner.build_parser "Link to this definition")
    :   Run plugins affecting the `parser` without yet parsing arguments.

    parse\_args(*args=None*)[¶](#snakebids.bidsapp.run._Runner.parse_args "Link to this definition")
    :   Run all plugins and parse arguments.

        Parameters:
        :   **args** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* *None*)

    run(*args=None*)[¶](#snakebids.bidsapp.run._Runner.run "Link to this definition")
    :   Parameters:
        :   **args** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* *None*)

[Next

Internals](internals.html)
[Previous

Data Structures](structures.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* BIDS App Bootstrapping
  + [`SnakeBidsApp`](#snakebids.app.SnakeBidsApp)
    - [`SnakeBidsApp.config`](#snakebids.app.SnakeBidsApp.config)
    - [`SnakeBidsApp.parser`](#snakebids.app.SnakeBidsApp.parser)
    - [`SnakeBidsApp.run_snakemake()`](#snakebids.app.SnakeBidsApp.run_snakemake)
    - [`SnakeBidsApp.create_descriptor()`](#snakebids.app.SnakeBidsApp.create_descriptor)
  + [BIDS App](#module-snakebids.bidsapp)
    - [`app()`](#snakebids.bidsapp.app)
    - [`_Runner`](#snakebids.bidsapp.run._Runner)
      * [`_Runner.pm`](#snakebids.bidsapp.run._Runner.pm)
      * [`_Runner.parser`](#snakebids.bidsapp.run._Runner.parser)
      * [`_Runner.config`](#snakebids.bidsapp.run._Runner.config)
      * [`_Runner.argument_groups`](#snakebids.bidsapp.run._Runner.argument_groups)
      * [`_Runner.build_parser()`](#snakebids.bidsapp.run._Runner.build_parser)
      * [`_Runner.parse_args()`](#snakebids.bidsapp.run._Runner.parse_args)
      * [`_Runner.run()`](#snakebids.bidsapp.run._Runner.run)