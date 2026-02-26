# crisprme CWL Generation Report

## crisprme_crisprme.py

### Tool Description
CRISPRme is a tool for analyzing CRISPR-Cas9 off-target effects.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
- **Homepage**: https://github.com/samuelecancellieri/CRISPRme
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Total Downloads**: 459.2K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/samuelecancellieri/CRISPRme
- **Stars**: N/A
### Original Help Text
```text
ERROR! --help is not an allowed command!

Help:

- ALL FASTA FILEs USED BY THE SOFTWARE MUST BE UNZIPPED AND SEPARATED BY CHROMOSOME
- ALL VCFs USED BY THE SOFTWARE MUST BE ZIPPED (WITH BGZIP) AND SEPARATED BY CHROMOSOME

Functionalities:

crisprme.py complete-search
	Performs genome-wide off-targets search (reference and variant, if specified), including CFD and CRISTA analysis, and target selection

crisprme.py complete-test
	Test the complete CRISPRme pipeline on single chromosomes or complete genomes

crisprme.py validate-test
	Validate targets obtained from complete-test by comparing them against brute-force search and alignment results

crisprme.py targets-integration
	Integrates in-silico targets with empirical data to generate a usable panel

crisprme.py gnomAD-converter
	Converts gnomAD VCF files into CRISPRme compatible VCFs (supports gnomAD >= v3.1)

crisprme.py generate-personal-card
	Generates a personal card for specific samples by extracting all private targets

crisprme.py web-interface
	Activates CRISPRme's web interface for local browser use

crisprme.py --version
	Prints CRISPRme version to stdout and exit

For additional information on each CRISPRme functionality type <function> --help (e.g. 'crisprme.py complete-search --help')
```

