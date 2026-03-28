[Skip to content](#content)

[![Logo](../../_static/logo-snake.svg)
![Logo](../../_static/logo-snake.svg)Snakedeploy documentation](../../index.html)
[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Toggle navigation menu

`⌘
K`

[![Logo](../../_static/logo-snake.svg)
![Logo](../../_static/logo-snake.svg)Snakedeploy documentation](../../index.html)

[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Getting started

* [Installation](../../getting_started/installation.html)

Workflow users

* [Deploy workflows](../../workflow_users/workflow_deployment.html)
* [Register input data](../../workflow_users/input_registration.html)

Workflow developers

* [Update conda environment files](../../workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](../../workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](../../workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](../../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../snakedeploy.html)
* Internal API

[Snakedeploy documentation](../../index.html)

/

Internal API

# Internal API

These pages document the entire internal API of Snakedeploy.

* [snakedeploy package](snakedeploy.html)
  + [Submodules](snakedeploy.html#submodules)
  + [snakedeploy.client module](snakedeploy.html#module-snakedeploy.client)
    - [`get_parser()`](snakedeploy.html#snakedeploy.client.get_parser)
    - [`main()`](snakedeploy.html#snakedeploy.client.main)
  + [snakedeploy.providers module](snakedeploy.html#module-snakedeploy.providers)
    - [`Github`](snakedeploy.html#snakedeploy.providers.Github)
      * [`Github.checkout()`](snakedeploy.html#snakedeploy.providers.Github.checkout)
      * [`Github.clone()`](snakedeploy.html#snakedeploy.providers.Github.clone)
      * [`Github.get_raw_file()`](snakedeploy.html#snakedeploy.providers.Github.get_raw_file)
      * [`Github.get_source_file_declaration()`](snakedeploy.html#snakedeploy.providers.Github.get_source_file_declaration)
      * [`Github.matches()`](snakedeploy.html#snakedeploy.providers.Github.matches)
      * [`Github.name`](snakedeploy.html#snakedeploy.providers.Github.name)
    - [`Gitlab`](snakedeploy.html#snakedeploy.providers.Gitlab)
      * [`Gitlab.get_raw_file()`](snakedeploy.html#snakedeploy.providers.Gitlab.get_raw_file)
    - [`Local`](snakedeploy.html#snakedeploy.providers.Local)
      * [`Local.checkout()`](snakedeploy.html#snakedeploy.providers.Local.checkout)
      * [`Local.clone()`](snakedeploy.html#snakedeploy.providers.Local.clone)
      * [`Local.get_raw_file()`](snakedeploy.html#snakedeploy.providers.Local.get_raw_file)
      * [`Local.get_source_file_declaration()`](snakedeploy.html#snakedeploy.providers.Local.get_source_file_declaration)
      * [`Local.matches()`](snakedeploy.html#snakedeploy.providers.Local.matches)
    - [`Provider`](snakedeploy.html#snakedeploy.providers.Provider)
      * [`Provider.checkout()`](snakedeploy.html#snakedeploy.providers.Provider.checkout)
      * [`Provider.clone()`](snakedeploy.html#snakedeploy.providers.Provider.clone)
      * [`Provider.get_raw_file()`](snakedeploy.html#snakedeploy.providers.Provider.get_raw_file)
      * [`Provider.get_repo_name()`](snakedeploy.html#snakedeploy.providers.Provider.get_repo_name)
      * [`Provider.matches()`](snakedeploy.html#snakedeploy.providers.Provider.matches)
    - [`get_provider()`](snakedeploy.html#snakedeploy.providers.get_provider)
  + [snakedeploy.logging module](snakedeploy.html#module-snakedeploy.logger)
    - [`ColorizingStreamHandler`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler)
      * [`ColorizingStreamHandler.BLACK`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.BLACK)
      * [`ColorizingStreamHandler.BLUE`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.BLUE)
      * [`ColorizingStreamHandler.BOLD_SEQ`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.BOLD_SEQ)
      * [`ColorizingStreamHandler.COLOR_SEQ`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.COLOR_SEQ)
      * [`ColorizingStreamHandler.CYAN`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.CYAN)
      * [`ColorizingStreamHandler.GREEN`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.GREEN)
      * [`ColorizingStreamHandler.MAGENTA`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.MAGENTA)
      * [`ColorizingStreamHandler.RED`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.RED)
      * [`ColorizingStreamHandler.RESET_SEQ`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.RESET_SEQ)
      * [`ColorizingStreamHandler.WHITE`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.WHITE)
      * [`ColorizingStreamHandler.YELLOW`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.YELLOW)
      * [`ColorizingStreamHandler.can_color_tty()`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.can_color_tty)
      * [`ColorizingStreamHandler.colors`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.colors)
      * [`ColorizingStreamHandler.decorate()`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.decorate)
      * [`ColorizingStreamHandler.emit()`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.emit)
      * [`ColorizingStreamHandler.is_tty`](snakedeploy.html#snakedeploy.logger.ColorizingStreamHandler.is_tty)
    - [`Logger`](snakedeploy.html#snakedeploy.logger.Logger)
      * [`Logger.cleanup()`](snakedeploy.html#snakedeploy.logger.Logger.cleanup)
      * [`Logger.debug()`](snakedeploy.html#snakedeploy.logger.Logger.debug)
      * [`Logger.error()`](snakedeploy.html#snakedeploy.logger.Logger.error)
      * [`Logger.exit()`](snakedeploy.html#snakedeploy.logger.Logger.exit)
      * [`Logger.handler()`](snakedeploy.html#snakedeploy.logger.Logger.handler)
      * [`Logger.info()`](snakedeploy.html#snakedeploy.logger.Logger.info)
      * [`Logger.location()`](snakedeploy.html#snakedeploy.logger.Logger.location)
      * [`Logger.progress()`](snakedeploy.html#snakedeploy.logger.Logger.progress)
      * [`Logger.set_level()`](snakedeploy.html#snakedeploy.logger.Logger.set_level)
      * [`Logger.set_stream_handler()`](snakedeploy.html#snakedeploy.logger.Logger.set_stream_handler)
      * [`Logger.shellcmd()`](snakedeploy.html#snakedeploy.logger.Logger.shellcmd)
      * [`Logger.text_handler()`](snakedeploy.html#snakedeploy.logger.Logger.text_handler)
      * [`Logger.warning()`](snakedeploy.html#snakedeploy.logger.Logger.warning)
    - [`setup_logger()`](snakedeploy.html#snakedeploy.logger.setup_logger)

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)