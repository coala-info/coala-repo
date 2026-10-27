# watchdog CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| watchdog_tricks-generate-yaml | PASS | stdout mode generates correct tricks YAML; the --append-to-file option crashes in this version (tool bug: bytes/str TypeError) |

## watchdog_tricks-generate-yaml

### Tool Description
Generate Yaml configuration for tricks named on the command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/watchdog:0.8.3--py36_0
- **Homepage**: https://github.com/gorakhargosh/watchdog
- **Package**: https://anaconda.org/channels/bioconda/packages/watchdog/overview
- **Validation**: PASS

### Original Help Text
```text
usage: watchmedo tricks-generate-yaml [-h] [--python-path PYTHON_PATH]
                                      [--append-to-file APPEND_TO_FILE] [-a]
                                      [trick_paths [trick_paths ...]]

    Subcommand to generate Yaml configuration for tricks named on the command
    line.

    :param args:
        Command line argument options.
    

positional arguments:
  trick_paths           Dotted paths for all the tricks you want to generate
                        (default: -)

optional arguments:
  -h, --help            show this help message and exit
  --python-path PYTHON_PATH
                        paths separated by / to add to the python path
                        (default: '.')
  --append-to-file APPEND_TO_FILE
                        appends the generated tricks YAML to a file; if not
                        specified, prints to standard output (default: -)
  -a, --append-only     if --append-to-file is not specified, produces output
                        for appending instead of a complete tricks yaml file.
                        (default: False)
```

