[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + [Get-tool-list](get-tool-list.html)
  + Run-data-managers
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.run_data_managers-_parser-named-arguments)
      * [General options](#ephemeris.run_data_managers-_parser-general-options)
      * [Galaxy connection](#ephemeris.run_data_managers-_parser-galaxy-connection)
  + [Setup-data-libraries](setup-data-libraries.html)
  + [Shed-tools](shed-tools.html)
  + [Install-tool-deps](install-tool-deps.html)
  + [Workflow-install](workflow-install.html)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Run-data-managers
* [View page source](../_sources/commands/run-data-managers.rst.txt)

---

# Run-data-managers[¶](#module-ephemeris.run_data_managers "Link to this heading")

Run-data-managers is a tool for provisioning data on a galaxy instance.

Run-data-managers has the ability to run multiple data managers that are interdependent.
When a reference genome is needed for bwa-mem for example, Run-data-managers
can first run a data manager to fetch the fasta file and run
another data manager that indexes the fasta file for bwa-mem.
This functionality depends on the “watch\_tool\_data\_dir” setting in galaxy.ini to be True.
Also, if a new data manager is installed, galaxy needs to be restarted in order for it’s tool\_data\_dir to be watched.

Run-data-managers needs a yaml that specifies what data managers are run and with which settings.
Example files can be found [here](https://github.com/galaxyproject/ephemeris/blob/master/tests/run_data_managers.yaml.sample),
[here](https://github.com/galaxyproject/ephemeris/blob/master/tests/run_data_managers.yaml.sample.advanced),
and [here](https://github.com/galaxyproject/ephemeris/blob/master/tests/run_data_managers.yaml.test).

By default run-data-managers skips entries in the yaml file that have already been run.
It checks it in the following way:

> * If the data manager has input variables “name” or “sequence\_name” it will check if the “name” column in the data table already has this entry.
>   “name” will take precedence over “sequence\_name”.
> * If the data manager has input variables “value”, “sequence\_id” or ‘dbkey’ it will check if the “value”
>   column in the data table already has this entry.
>   Value takes precedence over sequence\_id which takes precedence over dbkey.
> * If none of the above input variables are specified the data manager will always run.

## Usage[¶](#usage "Link to this heading")

Running Galaxy data managers in a defined order with defined parameters.’watch\_tool\_data\_dir’ in galaxy config should be set to true.’

```
usage: run-data-managers [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                         [-p PASSWORD] [-a API_KEY] --config CONFIG
                         [--overwrite] [--ignore-errors]
                         [--data-manager-mode {bundle,populate,dry_run}]
                         [--history-name HISTORY_NAME]
```

### Named Arguments[¶](#ephemeris.run_data_managers-_parser-named-arguments "Link to this heading")

`--config`
:   Path to the YAML config file with the list of data managers and data to install.

`--overwrite`
:   Disables checking whether the item already exists in the tool data table.

    Default: `False`

`--ignore-errors, --ignore_errors`
:   Do not stop running when jobs have failed.

    Default: `False`

`--data-manager-mode, --data_manager_mode`
:   Possible choices: bundle, populate, dry\_run

    Default: `'populate'`

`--history-name`

### General options[¶](#ephemeris.run_data_managers-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

`--log-file, --log_file`
:   Where the log file should be stored. Default is a file in your system’s temp folder

### Galaxy connection[¶](#ephemeris.run_data_managers-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

[Previous](get-tool-list.html "Get-tool-list")
[Next](setup-data-libraries.html "Setup-data-libraries")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).