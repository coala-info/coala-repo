# mlrho CWL Generation Report

## mlrho_mlRho

### Tool Description
Maximum likelihood estimation of population mutation, recombination, and disequilibrium measures

### Metadata
- **Docker Image**: quay.io/biocontainers/mlrho:2.9--ha9c9cc8_3
- **Homepage**: http://guanine.evolbio.mpg.de/mlRho/
- **Package**: https://anaconda.org/channels/bioconda/packages/mlrho/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mlrho/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: mlRho [options] [inputFile(s)]
Maximum likelihood estimation of population mutation, recombination, and disequilibrium measures
Example: mlRho -n test -M 0
standard options:
	[-n <FILE> name of database created using formatPro; default: profileDb]
	[-m <NUM> minimum distance analyzed in rho computation; default: 1]
	[-M <NUM> maximum distance analyzed in rho computation; default: all]
	[-S <NUM> step size in rho computation; default: 1]
	[-f <NUM> fraction of likelihood weight included in LD analysis; default: 0.00]
	[-o high memory mode; may be faster for disequilibrium analysis]
	[-I write likelihoods to file; default: likelihoods not written to file]
	[-L lump -S distance classes; default: no lumping]
	[-c corrected diversity measure according to Lynch (2008), p. 2412; default: uncorrected]
	[-v print program version, etc. and exit]
	[-h print this help message and exit]
extra options:
	[-P <NUM> initial theta value; default:  1.000e-03]
	[-E <NUM> initial epsilon value; default:  1.000e-03]
	[-D <NUM> initial delta value; default:  1.000e-03]
	[-t <NUM> simplex size threshold; default:  1.000e-08]
	[-s <NUM> size of first step in ML estimation; default:  1.000e-04]
```

