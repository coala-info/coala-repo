# icescreen CWL Generation Report

## icescreen

### Tool Description
ICEscreen version 1.3.3

### Metadata
- **Docker Image**: quay.io/biocontainers/icescreen:1.3.3--py312h7e72e81_0
- **Homepage**: https://forgemia.inra.fr/ices_imes_analysis/icescreen
- **Package**: https://anaconda.org/channels/bioconda/packages/icescreen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/icescreen/overview
- **Total Downloads**: 20.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ICEscreen version 1.3.3

* Command line for running an analysis with ICEscreen:
	icescreen [-o OUTDIR] [-n ANALYSIS_NAME] [-j NB_JOBS] -p TAXONMIC_PHYLUM -g GBDIR

* Mandatory arguments for running icescreen:
	-g, --gbdir                 : Path to the folder containing the genbank files (Mandatory). Multigenbank files are supported. Each Genbank file must include the ORIGIN nucleotide sequence at the end.

* Soon to be mandatory arguments for running icescreen:
	-p, --phylum                : Phylum of the organisms to analyse. Supported phylum: "bacillota".

* Optional arguments for running icescreen:
	-o, --outdir                : Path to where ICEscreen results will be written (default /root).
	-n, --name                  : Name of the analysis (default None).
	-j, --jobs                  : Maximum number of processes running in parallel (default 1).
	--galaxy                    : Do not try to activate the default icescreen_env Conda environment before running icescreen. This option allows to run ICEscreen on a Galaxy instance.

* Other arguments (admin, settings, help, etc.):
	-h, --help                  : Show this message and exit.
	-v, --version               : Show the version of ICEscreen and exit.
	--install_dependencies      : Uninstall and re-install the dependencies of ICEscreen via Conda.
	--print_version_dependencies: Show the version of the dependencies for ICEscreen and exit.
	--index_genomic_resources   : Index or re-index the genomic resources related to the signature proteins used by ICEscreen (proteins fasta via makeblastdb and HMM profiles via hmmpress) and exit.
	--test_installation         : Test whether the process of installing ICEscreen was successful and exit. If so, the sentence "The installation of ICEscreen is successful" will appear.
```

