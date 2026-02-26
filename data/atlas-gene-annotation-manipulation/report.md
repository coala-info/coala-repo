# atlas-gene-annotation-manipulation CWL Generation Report

## atlas-gene-annotation-manipulation_gtf2featureAnnotation.R

### Tool Description
R script for manipulating GTF files to create feature annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/atlas-gene-annotation-manipulation:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/atlas-gene-annotation-manipulation
- **Package**: https://anaconda.org/channels/bioconda/packages/atlas-gene-annotation-manipulation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atlas-gene-annotation-manipulation/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/atlas-gene-annotation-manipulation
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/gtf2featureAnnotation.R [options]


Options:
	-g GTF-FILE, --gtf-file=GTF-FILE
		Path to a valid GTF file

	-t FEATURE-TYPE, --feature-type=FEATURE-TYPE
		Feature type to use (default: gene)

	-f FIRST-FIELD, --first-field=FIRST-FIELD
		Field to place first in output table (default: gene_id)

	-r, --no-header
		Suppress header on output

	-l FIELDS, --fields=FIELDS
		Comma-separated list of output fields to retain (default: all)

	-m, --mito
		Mark mitochondrial elements with reference to chromsomes and biotypes

	-n MITO-CHR, --mito-chr=MITO-CHR
		If specified, marks in a column called "mito" features on the specified chromosomes (case insensitive)

	-p MITO-BIOTYPES, --mito-biotypes=MITO-BIOTYPES
		If specified,  marks in a column called "mito" features with the specified biotypes (case insensitve)

	-c PARSE-CDNAS, --parse-cdnas=PARSE-CDNAS
		Provide a cDNA file for extracting meta info and/or filtering.

	-y, --parse-cdna-names
		Where --parse-cdnas is specified, parse out info from the Fasta name. Will likely only work for Ensembl GTFs

	-d PARSE-CDNA-FIELD, --parse-cdna-field=PARSE-CDNA-FIELD
		Where --parse-cdnas is specified, what field should be used to compare to identfiers from the FASTA?

	-i FILL-EMPTY, --fill-empty=FILL-EMPTY
		Where --fields is specified, fill empty specified columns with the content of the specified field. Useful when you need to guarantee a value, for example a gene ID for a transcript/gene mapping. 

	-e FILTER-CDNAS-OUTPUT, --filter-cdnas-output=FILTER-CDNAS-OUTPUT
		Where --parse-cdnas is specified, filter sequences and output to the specified file. No file will be output if this is not specified (for example for use of --dummy-from-cdnas only).

	-u, --version-transcripts
		Where the GTF contains transcript versions, should these be appended to transcript identifiers? Useful when generating transcript/gene mappings for use with transcriptomes. NOTE: if --filter-cdnas-field is set, the setting of this field is set to best match transcript identifiers in the cDNAs FASTA.

	-o OUTPUT-FILE, --output-file=OUTPUT-FILE
		Output file path

	-h, --help
		Show this help message and exit
```

