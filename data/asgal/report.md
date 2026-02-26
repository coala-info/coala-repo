# asgal CWL Generation Report

## asgal

### Tool Description
ASGAL - Alternative Splicing Graph ALigner

### Metadata
- **Docker Image**: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
- **Homepage**: https://asgal.algolab.eu/
- **Package**: https://anaconda.org/channels/bioconda/packages/asgal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/asgal/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: asgal [-h] -g REFPATH -a ANNOPATH -s SAMPLE1PATH -o OUTPUTPATH
             [-s2 SAMPLE2PATH] [-t TRANSPATH] [-l L] [-e E] [-w W]
             [--allevents] [--multi] [--verbose] [--debug] [--split-only]
             [-@ THREADS] [-v]

ASGAL - Alternative Splicing Graph ALigner

options:
  -h, --help            show this help message and exit
  -g REFPATH, --genome REFPATH
                        Path to genome (default: None)
  -a ANNOPATH, --annotation ANNOPATH
                        Path to annotation (default: None)
  -s SAMPLE1PATH, --sample SAMPLE1PATH
                        Path to sample (1) (default: None)
  -o OUTPUTPATH, --output OUTPUTPATH
                        Path to output folder (default: None)
  -s2 SAMPLE2PATH, --sample2 SAMPLE2PATH
                        Path to sample (2) (default: -)
  -t TRANSPATH, --transcripts TRANSPATH
                        Path to transcripts (default: -)
  -l L, --L L           MEMs length (default: 15)
  -e E, --erate E       Error rate (default: 3)
  -w W, --support W     Minimum intron coverage (default: 3)
  --allevents           Use this if you want to detect all events, also
                        annotated ones (default: False)
  --multi               Use this to run ASGAL in genome-wide mode (default:
                        False)
  --verbose             Add some prints to stderr (default: False)
  --debug               Add debug prints to stderr (default: False)
  --split-only          Only split files per gene, do not run ASGAL (default:
                        False)
  -@ THREADS, --threads THREADS
                        Number of threads to use for salmon mapping and
                        parallel gene computation (default: 2)
  -v, --version         show program's version number and exit
```

