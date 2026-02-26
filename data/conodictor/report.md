# conodictor CWL Generation Report

## conodictor

### Tool Description
Improved prediction of conopeptide superfamilies with ConoDictor 2.0

### Metadata
- **Docker Image**: biocontainers/conodictor:v2.3.1_cv1
- **Homepage**: https://github.com/koualab/conodictor
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conodictor/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/koualab/conodictor
- **Stars**: N/A
### Original Help Text
```text
usage: 
  _____                  _____  _      _             
 / ____|                |  __ \(_)    | |            
| |     ___  _ __   ___ | |  | |_  ___| |_ ___  _ __ 
| |    / _ \| '_ \ / _ \| |  | | |/ __| __/ _ \| '__|
| |___| (_) | | | | (_) | |__| | | (__| || (_) | |   
 \_____\___/|_| |_|\___/|_____/|_|\___|\__\___/|_|    v2.3.1

If you use this software, please cite:
Dominique Koua, Anicet Ebou, Sébastien Dutertre
Improved prediction of conopeptide superfamilies with ConoDictor 2.0
Bioinformatics Advances, 2021;, vbab011, https://doi.org/10.1093/bioadv/vbab011

conodictor [FLAGS/OPTIONS] <file>

Examples:
	conodictor file.fa.gz
	conodictor --out outfolder --cpus 4 --mlen 51 file.fa

positional arguments:
  file                  Specifies input file.

optional arguments:
  -h, --help            show this help message and exit
  -o OUT, --out OUT     Specify output folder.
  --mlen MLEN           Set the minimum length of the sequence to be
                        considered as a match
  --ndup NDUP           Minimum sequence occurence of a sequence to be
                        considered
  --faa                 Create a fasta file of matched sequences. Default:
                        False.
  --filter              Activate the removal of sequences that matches only
                        the signal and/or proregions. Default: False.
  -a, --all             Display sequence without hits in output. Default:
                        False.
  -j CPUS, --cpus CPUS  Specify the number of threads. Default: 1.
  --force               Force re-use output directory. Default: Off.
  -q, --quiet           Decrease program verbosity
  --debug               Activate debug mode

Licence:   GPL-3
Homepage:  https://github.com/koualab/conodictor.git
```

