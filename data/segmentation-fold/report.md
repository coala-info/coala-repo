# segmentation-fold CWL Generation Report

## segmentation-fold

### Tool Description
Calculates RNA secondary structure and folding parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
- **Homepage**: https://github.com/shreyapamecha/Speed-Estimation-of-Vehicles-with-Plate-Detection
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segmentation-fold/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shreyapamecha/Speed-Estimation-of-Vehicles-with-Plate-Detection
- **Stars**: N/A
### Original Help Text
```text
Usage: segmentation-fold -s [SEQUENCE]
       segmentation-fold -f [FASTA_FILE]
   * Note: If FASTA_FILE and SEQUENCE are not provided,
           the program will read from STDIN.


The following parameters can be used:
  -s SEQUENCE       Specific RNA SEQUENCE (overrules -f)
  -f FASTA_FILE     Path of FASTA_FILE containing sequence(s)
  -p                Enable/disable segment functionality           [1/0]
  -H HAIRPINSIZE    Minimum hairpin size, default: 3               [1,N}
  -x SEGMENTS_XML   Use custom  "segments.xml"-syntaxed file
  -t NUM_THREADS    Number of threads; 0 = maximum available,      [0,N}
                    default: 3 

  -h, --help        Display this help and exit
  -V, --version     Show version and license
  -X, --default-xml Show path to default "segments.xml" on
                    system


If you encounter problems with this software, please report it at:
   <https://github.com/yhoogstrate/segmentation-fold/issues>
```


## Metadata
- **Skill**: generated
