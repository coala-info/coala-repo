# rnasketch CWL Generation Report

## rnasketch_design-multistate.py

### Tool Description
Design a multi-stable riboswitch similar to Hoehner 2013 paper.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Total Downloads**: 10.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ViennaRNA/RNAsketch
- **Stars**: N/A
### Original Help Text
```text
usage: design-multistate.py [-h] [-f FILE] [-i] [-q PACKAGE] [-j OBJECTIVE]
                            [-T TEMPERATURE] [-n NUMBER] [-s STOP] [-m MODE]
                            [-k KILL] [-g GRAPHML] [-c] [-p] [-d]

Design a multi-stable riboswitch similar to Hoehner 2013 paper.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Read file in *.inp format
  -i, --input           Read custom structures and sequence constraints from
                        stdin
  -q PACKAGE, --package PACKAGE
                        Chose the calculation package: hotknots, pkiss,
                        nupack, or vrna/ViennaRNA (default: vrna)
  -j OBJECTIVE, --objective OBJECTIVE
                        Chose the objective function: 1 for abs differences
                        and 2 for squared (default: 1)
  -T TEMPERATURE, --temperature TEMPERATURE
                        Temperature of the energy calculations.
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -s STOP, --stop STOP  Stop optimization run if no better solution is aquired
                        after (stop) trials.
  -m MODE, --mode MODE  Mode for getting a new sequence: sample,
                        sample_plocal, sample_clocal, random
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -g GRAPHML, --graphml GRAPHML
                        Write a graphml file with the given filename.
  -c, --csv             Write output as semi-colon csv file to stdout
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
```


## rnasketch_design-thermoswitch.py

### Tool Description
Design a multi-stable thermoswitch as suggested in the Flamm 2001 publication.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design-thermoswitch.py [-h] [-q PACKAGE] [-n NUMBER] [-e STOP]
                              [-m MODE] [-k KILL] [-g GRAPHML] [-c] [-p] [-d]

Design a multi-stable thermoswitch as suggested in the Flamm 2001 publication.

optional arguments:
  -h, --help            show this help message and exit
  -q PACKAGE, --package PACKAGE
                        Chose the calculation package: hotknots, pkiss,
                        nupack, or vrna/ViennaRNA (default: vrna)
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -e STOP, --stop STOP  Stop optimization run if no better solution is aquired
                        after (stop) trials.
  -m MODE, --mode MODE  Mode for getting a new sequence: sample,
                        sample_plocal, sample_clocal, random
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -g GRAPHML, --graphml GRAPHML
                        Write a graphml file with the given filename.
  -c, --csv             Write output as semi-colon csv file to stdout
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
```


## rnasketch_design-ligandswitch.py

### Tool Description
Design a ligand triggered device.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design-ligandswitch.py [-h] [-f FILE] [-i] [-r RATIO] [-l LIGAND]
                              [-T TEMPERATURE] [-n NUMBER] [-s STOP] [-m MODE]
                              [-k KILL] [-g GRAPHML] [-c] [-p] [-d]

Design a ligand triggered device.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Read file in *.inp format
  -i, --input           Read custom structures and sequence constraints from
                        stdin
  -r RATIO, --ratio RATIO
                        Ratio of the alternative to binding competent state in
                        percent (default: 90:10)
  -l LIGAND, --ligand LIGAND
                        Binding motif and energy of the ligand (default:
                        "GAUACCAG&CCCUUGGCAGC;(...((((&)...)))...);-9.22")
  -T TEMPERATURE, --temperature TEMPERATURE
                        Temperature of the energy calculations.
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -s STOP, --stop STOP  Stop optimization run if no better solution is aquired
                        after (stop) trials.
  -m MODE, --mode MODE  Mode for getting a new sequence: sample,
                        sample_plocal, sample_clocal, random
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -g GRAPHML, --graphml GRAPHML
                        Write a graphml file with the given filename.
  -c, --csv             Write output as semi-colon csv file to stdout
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
```


## rnasketch_design-cofold.py

### Tool Description
Design a cofold device.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design-cofold.py [-h] [-i] [-q PACKAGE] [-T TEMPERATURE] [-n NUMBER]
                        [-s STOP] [-m MODE] [-k KILL] [-g GRAPHML] [-c] [-p]
                        [-d] [-r REPORTER]

Design a cofold device.

optional arguments:
  -h, --help            show this help message and exit
  -i, --input           Read custom structures and sequence constraints from
                        stdin
  -q PACKAGE, --package PACKAGE
                        Chose the calculation package: hotknots, pkiss,
                        nupack, or vrna/ViennaRNA (default: vrna)
  -T TEMPERATURE, --temperature TEMPERATURE
                        Temperature of the energy calculations.
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -s STOP, --stop STOP  Stop optimization run if no better solution is aquired
                        after (stop) trials.
  -m MODE, --mode MODE  Mode for getting a new sequence: sample,
                        sample_plocal, sample_clocal, random
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -g GRAPHML, --graphml GRAPHML
                        Write a graphml file with the given filename.
  -c, --csv             Write output as semi-colon csv file to stdout
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
  -r REPORTER, --reporter REPORTER
                        The coding sequence context, excluding the start codon
                        that should be part of the sequence constraint.
                        Default are the first 66 nucleotides of eGFP.
```


## rnasketch_design-redprint-multistate.py

### Tool Description
Design a multi-stable riboswitch similar using Boltzmann sampling.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design-redprint-multistate.py [-h] [-f FILE] [-i] [-q PACKAGE]
                                     [-j OBJECTIVE] [-T TEMPERATURE]
                                     [-n NUMBER] [-m MODEL] [-s STOP]
                                     [-k KILL] [-g GRAPHML] [-c] [-p] [-d]

Design a multi-stable riboswitch similar using Boltzmann sampling.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Read file in *.inp format
  -i, --input           Read custom structures and sequence constraints from
                        stdin
  -q PACKAGE, --package PACKAGE
                        Chose the calculation package: hotknots, pkiss,
                        nupack, or vrna/ViennaRNA (default: vrna)
  -j OBJECTIVE, --objective OBJECTIVE
                        Chose the objective function: 1 for abs differences
                        and 2 for squared (default: 1)
  -T TEMPERATURE, --temperature TEMPERATURE
                        Temperature of the energy calculations.
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -m MODEL, --model MODEL
                        Model for getting a new sequence: uniform, nussinov,
                        basepairs, stacking
  -s STOP, --stop STOP  Stop optimization run of unpaired bases if no better
                        solution is aquired after (stop) trials. 0 is no
                        unpaired bases optimization.
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -g GRAPHML, --graphml GRAPHML
                        Write a graphml file with the given filename.
  -c, --csv             Write output as semi-colon csv file to stdout
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
```


## rnasketch_design-energyshift.py

### Tool Description
Design a multi-stable riboswitch similar using Boltzmann sampling.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasketch:1.5--py27_1
- **Homepage**: https://github.com/ViennaRNA/RNAsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasketch/overview
- **Validation**: PASS

### Original Help Text
```text
usage: design-energyshift.py [-h] [-f FILE] [-i] [-q PACKAGE] [-j OBJECTIVE]
                             [-T TEMPERATURE] [-n NUMBER] [-m MODEL]
                             [-e ENERGIES] [-s STOP] [-c] [-k KILL] [-p] [-d]

Design a multi-stable riboswitch similar using Boltzmann sampling.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Read file in *.inp format
  -i, --input           Read custom structures and sequence constraints from
                        stdin
  -q PACKAGE, --package PACKAGE
                        Chose the calculation package: hotknots, pkiss,
                        nupack, or vrna/ViennaRNA (default: vrna)
  -j OBJECTIVE, --objective OBJECTIVE
                        Chose the objective function: 1 for abs differences
                        and 2 for squared (default: 1)
  -T TEMPERATURE, --temperature TEMPERATURE
                        Temperature of the energy calculations.
  -n NUMBER, --number NUMBER
                        Number of designs to generate
  -m MODEL, --model MODEL
                        Model for getting a new sequence: uniform, nussinov,
                        basepairs, stacking
  -e ENERGIES, --energies ENERGIES
                        Target Energies for design. String of comma separated
                        float values.
  -s STOP, --stop STOP  Stop optimization run of unpaired bases if no better
                        solution is aquired after (stop) trials. 0 is no local
                        optimization.
  -c, --csv             Write output as semi-colon csv file to stdout
  -k KILL, --kill KILL  Timeout value of graph construction in seconds.
                        (default: infinite)
  -p, --progress        Show progress of optimization
  -d, --debug           Show debug information of library
```

