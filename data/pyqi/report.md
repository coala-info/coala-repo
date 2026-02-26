# pyqi CWL Generation Report

## pyqi_make-bash-completion

### Tool Description
Construct a bash tab completion script that will search through available commands and options

### Metadata
- **Docker Image**: quay.io/biocontainers/pyqi:0.3.2--py27_1
- **Homepage**: https://github.com/qir-alliance/pyqir
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyqi/overview
- **Total Downloads**: 59.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qir-alliance/pyqir
- **Stars**: N/A
### Original Help Text
```text
Usage: pyqi make-bash-completion [options] {--command-config-module COMMAND-CONFIG-MODULE --driver-name DRIVER-NAME -o/--output-fp OUTPUT-FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

Construct a bash tab completion script that will search through available commands and options

Example usage: 
Print help message and exit
 pyqi make-bash-completion -h

Create a bash completion script: Create a bash completion script for use with a pyqi driver
 pyqi make-bash-completion --command-config-module pyqi.interfaces.optparse.config --driver-name pyqi -o ~/.bash_completion.d/pyqi

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit

  REQUIRED options:
    The following options must be provided under all circumstances.

    --command-config-module=COMMAND_CONFIG_MODULE
                        CLI command configuration module [REQUIRED]
    --driver-name=DRIVER_NAME
                        name of the driver script [REQUIRED]
    -o OUTPUT_FP, --output-fp=OUTPUT_FP
                        output filepath [REQUIRED]
```


## pyqi_make-command

### Tool Description
This command is intended to construct the basics of a Command object so that a developer can dive straight into the implementation of the command

### Metadata
- **Docker Image**: quay.io/biocontainers/pyqi:0.3.2--py27_1
- **Homepage**: https://github.com/qir-alliance/pyqir
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: pyqi make-command [options] {-n/--name NAME -o/--output-fp OUTPUT-FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

This command is intended to construct the basics of a Command object so that a developer can dive straight into the implementation of the command

Example usage: 
Print help message and exit
 pyqi make-command -h

Basic Command: Create a basic Command with appropriate attribution
 pyqi make-command -n example -a "some author" -c "Copyright 2013, The pyqi project" -e "foo@bar.com" -l BSD --command-version "0.1" --credits "someone else","and another person" -o example.py

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -a AUTHOR, --author=AUTHOR
                        author/maintainer name [default: none]
  -e EMAIL, --email=EMAIL
                        maintainer email address [default: none]
  -l LICENSE, --license=LICENSE
                        license (e.g., BSD) [default: none]
  -c COPYRIGHT, --copyright=COPYRIGHT
                        copyright (e.g., Copyright 2013, The pyqi project)
                        [default: none]
  --command-version=COMMAND_VERSION
                        version (e.g., 0.1) [default: none]
  --credits=CREDITS     comma-separated list of other authors [default: none]
  --test-code           create stubbed out unit test code [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -n NAME, --name=NAME
                        the name of the Command [REQUIRED]
    -o OUTPUT_FP, --output-fp=OUTPUT_FP
                        output filepath to store generated Python code
                        [REQUIRED]
```


## pyqi_make-optparse

### Tool Description
Construct and stub out the basic optparse configuration for a given Command. This template provides comments and examples of what to fill in.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyqi:0.3.2--py27_1
- **Homepage**: https://github.com/qir-alliance/pyqir
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: pyqi make-optparse [options] {-c/--command COMMAND -m/--command-module COMMAND-MODULE -o/--output-fp OUTPUT-FP}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

Construct and stub out the basic optparse configuration for a given Command. This template provides comments and examples of what to fill in.

Example usage: 
Print help message and exit
 pyqi make-optparse -h

Create an optparse config template: Construct the beginning of an optparse configuration file based on the Parameters required by the Command.
 pyqi make-optparse -c pyqi.commands.make_optparse.MakeOptparse -m pyqi.commands.make_optparse -a "some author" --copyright "Copyright 2013, The pyqi project" -e "foo@bar.com" -l BSD --config-version "0.1" --credits "someone else","and another person" -o pyqi/interfaces/optparse/config/make_optparse.py

Create a different optparse config template: Construct the beginning of an optparse configuration file based on the Parameters required by the Command. This command corresponds to the pyqi tutorial example where a sequence_collection_summarizer command line interface is created for a SequenceCollectionSummarizer Command.
 pyqi make-optparse -c sequence_collection_summarizer.SequenceCollectionSummarizer -m sequence_collection_summarizer -a "Greg Caporaso" --copyright "Copyright 2013, Greg Caporaso" -e "gregcaporaso@gmail.com" -l BSD --config-version 0.0.1 -o summarize_sequence_collection.py

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -a AUTHOR, --author=AUTHOR
                        author/maintainer name [default: none]
  -e EMAIL, --email=EMAIL
                        maintainer email address [default: none]
  -l LICENSE, --license=LICENSE
                        license (e.g., BSD) [default: none]
  --copyright=COPYRIGHT
                        copyright (e.g., Copyright 2013, The pyqi project)
                        [default: none]
  --config-version=CONFIG_VERSION
                        version (e.g., 0.1) [default: none]
  --credits=CREDITS     comma-separated list of other authors [default: none]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -c COMMAND, --command=COMMAND
                        an existing Command [REQUIRED]
    -m COMMAND_MODULE, --command-module=COMMAND_MODULE
                        the Command source module [REQUIRED]
    -o OUTPUT_FP, --output-fp=OUTPUT_FP
                        output filepath to store generated optparse Python
                        configuration file [REQUIRED]
```


## pyqi_make-release

### Tool Description
Do all the things for a release

### Metadata
- **Docker Image**: quay.io/biocontainers/pyqi:0.3.2--py27_1
- **Homepage**: https://github.com/qir-alliance/pyqir
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: pyqi make-release [options] {--package-name PACKAGE-NAME}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

Do all the things for a release

Example usage: 
Print help message and exit
 pyqi make-release -h

Make a release: Make a release, tag it, update version strings and upload to pypi
 pyqi make-release --package-name=pyqi --real-run

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --real-run            Perform a real run [default: False]

  REQUIRED options:
    The following options must be provided under all circumstances.

    --package-name=PACKAGE_NAME
                        The name of the package to release [REQUIRED]
```


## pyqi_serve-html-interface

### Tool Description
Start the HTMLInterface server and load the provided interface_module and port

### Metadata
- **Docker Image**: quay.io/biocontainers/pyqi:0.3.2--py27_1
- **Homepage**: https://github.com/qir-alliance/pyqir
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: pyqi serve-html-interface [options] {-m/--interface-module INTERFACE-MODULE}

[] indicates optional input (order unimportant)
{} indicates required input (order unimportant)

Start the HTMLInterface server and load the provided interface_module and port

Example usage: 
Print help message and exit
 pyqi serve-html-interface -h

Start html interface: Starts an html interface server on the specified --port and --interface-module
 pyqi serve-html-interface -p 8080 -m pyqi.interfaces.html.config

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -p PORT, --port=PORT  The port to run the server on [default: 8080]

  REQUIRED options:
    The following options must be provided under all circumstances.

    -m INTERFACE_MODULE, --interface-module=INTERFACE_MODULE
                        The module to serve the interface for [REQUIRED]
```


## Metadata
- **Skill**: generated
