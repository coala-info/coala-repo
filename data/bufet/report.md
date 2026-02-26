# bufet CWL Generation Report

## bufet_bufet.py

### Tool Description
Run BUFET analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/bufet:1.0--py35h470a237_0
- **Homepage**: https://github.com/diwis/BUFET/
- **Package**: https://anaconda.org/channels/bioconda/packages/bufet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bufet/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/diwis/BUFET
- **Stars**: N/A
### Original Help Text
```text
Usage:
		python bufet.py [options]

Mandatory arguments:

	-miRNA <filePath>: path to the miRNA group file
	-interactions filePath>: path to the interactions file
	-ontology <filePath>: path to the ontology file
	-synonyms <filePath>: path to the synonyms file

Additional options:

	-iterations: number of random permutations
	-output <filePath>: path to the output file (overwritten if it exists)
	-processors: number of threads to use for calculations
	-species: "human" or "mouse"
	-miFree: miRanda free energy (valid only if the --miRanda flag is invoked)
	-miScore: miRanda free energy (valid only if the --miRanda flag is invoked)

	--miRanda: use interactions file from miRanda run
	--ensGO: use ontology file downloaded from Ensembl
	--disable-file-check: (quicker but not recommended) disable all file validations.
	--disable-interactions-check: (quicker but not recommended) disable existence and file format validation for the interactions file.
	--disable-ontology-check: (quicker but not recommended) disable existence and file format validation for the ontology file.
	--disable-synonyms-check: (quicker but not recommended) disable existence and file format validation for the synonyms file.
	--help: print this message and exit
```

