# physiofit CWL Generation Report

## physiofit

### Tool Description
Extracellular flux estimation software

### Metadata
- **Docker Image**: quay.io/biocontainers/physiofit:3.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/MetaSys-LISBP/PhysioFit
- **Package**: https://anaconda.org/channels/bioconda/packages/physiofit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/physiofit/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MetaSys-LISBP/PhysioFit
- **Stars**: N/A
### Original Help Text
```text
usage: Physiofit: Extracellular flux estimation software [-h] [-d DATA]
                                                         [-c CONFIG]
                                                         [-m MODEL] [-g]
                                                         [--list] [-v]
                                                         [-oc OUTPUT_CONFIG]
                                                         [-or OUTPUT_RECAP]
                                                         [-oz OUTPUT_ZIP]

options:
  -h, --help            show this help message and exit
  -d DATA, --data DATA  Path to data file in tabulated format (txt or tsv)
  -c CONFIG, --config CONFIG
                        Path to config file in yaml format
  -m MODEL, --model MODEL
                        Which model should be chosen. Useful only if
                        generating related config file
  -g, --galaxy          Is the CLI being used on the galaxy platform
  --list                Return the list of models in model folder
  -v, --debug_mode      Activate the debug logs
  -oc OUTPUT_CONFIG, --output_config OUTPUT_CONFIG
                        Path to output the yaml config file
  -or OUTPUT_RECAP, --output_recap OUTPUT_RECAP
                        Path to output the summary
  -oz OUTPUT_ZIP, --output_zip OUTPUT_ZIP
                        Path to export zip file
```

