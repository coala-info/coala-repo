### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index")
* [next](stages.html "Stages")
* [previous](config.html "Configuration")
* [YMP Extensible Omics Pipeline 0.2.1 documentation](index.html) »
* Command Line

# Command Line[¶](#command-line "Permalink to this headline")

## ymp[¶](#ymp "Permalink to this headline")

Welcome to YMP!

Please find the full manual at <https://ymp.readthedocs.io>

```
ymp [OPTIONS] COMMAND [ARGS]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-log-file "Permalink to this definition")
:   Specify a log file

`--version`[¶](#cmdoption-ymp-version "Permalink to this definition")
:   Show the version and exit.

`--install-completion`[¶](#cmdoption-ymp-install-completion "Permalink to this definition")
:   Install command completion for the current shell. Make sure to have psutil installed.

`--profile` `<profile>`[¶](#cmdoption-ymp-profile "Permalink to this definition")
:   Profile execution time using Yappi

### env[¶](#ymp-env "Permalink to this headline")

Manipulate conda software environments

These commands allow accessing the conda software environments managed
by YMP. Use e.g.

```
>>> $(ymp env activate multiqc)
```

to enter the software environment for `multiqc`.

```
ymp env [OPTIONS] COMMAND [ARGS]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-log-file "Permalink to this definition")
:   Specify a log file

#### activate[¶](#ymp-env-activate "Permalink to this headline")

source activate environment

Usage:
$(ymp activate env [ENVNAME])

```
ymp env activate [OPTIONS] ENVNAME
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-activate-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-activate-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-activate-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-activate-log-file "Permalink to this definition")
:   Specify a log file

Arguments

`ENVNAME`[¶](#cmdoption-ymp-env-activate-arg-ENVNAME "Permalink to this definition")
:   Required argument

#### clean[¶](#ymp-env-clean "Permalink to this headline")

Remove unused conda environments

```
ymp env clean [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-clean-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-clean-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-clean-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-clean-log-file "Permalink to this definition")
:   Specify a log file

`-a``,` `--all`[¶](#cmdoption-ymp-env-clean-a "Permalink to this definition")
:   Delete all environments

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-clean-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

#### export[¶](#ymp-env-export "Permalink to this headline")

Export conda environments

Resolved package specifications for the selected conda
environments can be exported either in YAML format suitable for
use with `conda env create -f FILE` or in TXT format containing
a list of URLs suitable for use with `conda create --file
FILE`. Please note that the TXT format is platform specific.

If other formats are desired, use `ymp env list` to view the
environments’ installation path (“prefix” in conda lingo) and
export the specification with the `conda` command line utlity
directly.

Note:

Environments must be installed before they can be exported. This is due

to limitations of the conda utilities. Use the “–create” flag to

automatically install missing environments.

```
ymp env export [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-export-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-export-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-export-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-export-log-file "Permalink to this definition")
:   Specify a log file

`-d``,` `--dest` `<FILE>`[¶](#cmdoption-ymp-env-export-d "Permalink to this definition")
:   Destination file or directory. If a directory, file names will be derived from environment names and selected export format. Default: print to standard output.

`-f``,` `--overwrite`[¶](#cmdoption-ymp-env-export-f "Permalink to this definition")
:   Overwrite existing files

`-c``,` `--create-missing`[¶](#cmdoption-ymp-env-export-c "Permalink to this definition")
:   Create environments not yet installed

`-s``,` `--skip-missing`[¶](#cmdoption-ymp-env-export-s "Permalink to this definition")
:   Skip environments not yet installed

`-t``,` `--filetype` `<filetype>`[¶](#cmdoption-ymp-env-export-t "Permalink to this definition")
:   Select export format. Default: yml unless FILE ends in ‘.txt’

    Options
    :   yml|txt

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-export-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

#### install[¶](#ymp-env-install "Permalink to this headline")

Install conda software environments

```
ymp env install [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-install-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-install-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-install-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-install-log-file "Permalink to this definition")
:   Specify a log file

`-p``,` `--conda-prefix` `<conda_prefix>`[¶](#cmdoption-ymp-env-install-0 "Permalink to this definition")
:   Override location for conda environments

`-e``,` `--conda-env-spec` `<conda_env_spec>`[¶](#cmdoption-ymp-env-install-e "Permalink to this definition")
:   Override conda env specs settings

`-n``,` `--dry-run`[¶](#cmdoption-ymp-env-install-n "Permalink to this definition")
:   Only show what would be done

`-f``,` `--force`[¶](#cmdoption-ymp-env-install-f "Permalink to this definition")
:   Install environment even if it already exists

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-install-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

#### list[¶](#ymp-env-list "Permalink to this headline")

List conda environments

```
ymp env list [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-list-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-list-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-list-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-list-log-file "Permalink to this definition")
:   Specify a log file

`--static``,` `--no-static`[¶](#cmdoption-ymp-env-list-static "Permalink to this definition")
:   List environments statically defined via env.yml files

`--dynamic``,` `--no-dynamic`[¶](#cmdoption-ymp-env-list-dynamic "Permalink to this definition")
:   List environments defined inline from rule files

`-a``,` `--all`[¶](#cmdoption-ymp-env-list-a "Permalink to this definition")
:   List all environments, including outdated ones.

`-s``,` `--sort` `<sort_col>`[¶](#cmdoption-ymp-env-list-s "Permalink to this definition")
:   Sort by column

    Options
    :   name|hash|path|installed

`-r``,` `--reverse`[¶](#cmdoption-ymp-env-list-r "Permalink to this definition")
:   Reverse sort order

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-list-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

#### prepare[¶](#ymp-env-prepare "Permalink to this headline")

Create envs needed to build target

```
ymp env prepare [OPTIONS] TARGET_FILES
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-prepare-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-prepare-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-prepare-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-prepare-log-file "Permalink to this definition")
:   Specify a log file

`-n``,` `--dryrun`[¶](#cmdoption-ymp-env-prepare-n "Permalink to this definition")
:   Only show what would be done

`-p``,` `--printshellcmds`[¶](#cmdoption-ymp-env-prepare-0 "Permalink to this definition")
:   Print shell commands to be executed on shell

`-k``,` `--keepgoing`[¶](#cmdoption-ymp-env-prepare-k "Permalink to this definition")
:   Don’t stop after failed job

`--lock``,` `--no-lock`[¶](#cmdoption-ymp-env-prepare-lock "Permalink to this definition")
:   Use/don’t use locking to prevent clobbering of files by parallel instances of YMP running

`--rerun-incomplete``,` `--ri`[¶](#cmdoption-ymp-env-prepare-rerun-incomplete "Permalink to this definition")
:   Re-run jobs left incomplete in last run

`-F``,` `--forceall`[¶](#cmdoption-ymp-env-prepare-F "Permalink to this definition")
:   Force rebuilding of all stages leading to target

`-f``,` `--force`[¶](#cmdoption-ymp-env-prepare-1 "Permalink to this definition")
:   Force rebuilding of target

`--notemp`[¶](#cmdoption-ymp-env-prepare-notemp "Permalink to this definition")
:   Do not remove temporary files

`-t``,` `--touch`[¶](#cmdoption-ymp-env-prepare-t "Permalink to this definition")
:   Only touch files, faking update

`--shadow-prefix` `<shadow_prefix>`[¶](#cmdoption-ymp-env-prepare-shadow-prefix "Permalink to this definition")
:   Directory to place data for shadowed rules

`-r``,` `--reason`[¶](#cmdoption-ymp-env-prepare-r "Permalink to this definition")
:   Print reason for executing rule

`-N``,` `--nohup`[¶](#cmdoption-ymp-env-prepare-N "Permalink to this definition")
:   Don’t die once the terminal goes away.

Arguments

`TARGET_FILES`[¶](#cmdoption-ymp-env-prepare-arg-TARGET_FILES "Permalink to this definition")
:   Optional argument(s)

#### remove[¶](#ymp-env-remove "Permalink to this headline")

Remove conda environments

```
ymp env remove [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-remove-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-remove-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-remove-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-remove-log-file "Permalink to this definition")
:   Specify a log file

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-remove-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

#### run[¶](#ymp-env-run "Permalink to this headline")

Execute COMMAND with activated environment ENV

Usage:
ymp env run <ENV> [–] <COMMAND…>

(Use the “–” if your command line contains option type parameters
:   beginning with - or –)

```
ymp env run [OPTIONS] ENVNAME [COMMAND]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-run-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-run-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-run-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-run-log-file "Permalink to this definition")
:   Specify a log file

Arguments

`ENVNAME`[¶](#cmdoption-ymp-env-run-arg-ENVNAME "Permalink to this definition")
:   Required argument

`COMMAND`[¶](#cmdoption-ymp-env-run-arg-COMMAND "Permalink to this definition")
:   Optional argument(s)

#### update[¶](#ymp-env-update "Permalink to this headline")

Update conda environments

```
ymp env update [OPTIONS] [ENVNAMES]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-env-update-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-env-update-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-env-update-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-env-update-log-file "Permalink to this definition")
:   Specify a log file

`--reinstall` `<reinstall>`[¶](#cmdoption-ymp-env-update-reinstall "Permalink to this definition")
:   Remove and reinstall environments rather than trying to update

Arguments

`ENVNAMES`[¶](#cmdoption-ymp-env-update-arg-ENVNAMES "Permalink to this definition")
:   Optional argument(s)

### init[¶](#ymp-init "Permalink to this headline")

Initialize YMP workspace

```
ymp init [OPTIONS] COMMAND [ARGS]...
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-init-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-init-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-init-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-init-log-file "Permalink to this definition")
:   Specify a log file

#### cluster[¶](#ymp-init-cluster "Permalink to this headline")

Set up cluster

```
ymp init cluster [OPTIONS]
```

Options

`-P``,` `--pdb`[¶](#cmdoption-ymp-init-cluster-P "Permalink to this definition")
:   Drop into debugger on uncaught exception

`-q``,` `--quiet`[¶](#cmdoption-ymp-init-cluster-q "Permalink to this definition")
:   Decrease log verbosity

`-v``,` `--verbose`[¶](#cmdoption-ymp-init-cluster-v "Permalink to this definition")
:   Increase log verbosity

`--log-file` `<log_file>`[¶](#cmdoption-ymp-init-cluster-log-file "Permalink to this definition")
:   Specify a log file

`-y``,` `--yes`[¶](#cmdoption-ymp-init-cluster-y "Permalink to this definition")
:   Confirm every prompt

#### demo[¶](#ymp-init-demo "Permalink to this headline")

Copies YMP tut