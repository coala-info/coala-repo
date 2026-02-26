# mendelscan CWL Generation Report

## mendelscan_score

### Tool Description
Score variants using MendelScan.

### Metadata
- **Docker Image**: quay.io/biocontainers/mendelscan:v1.2.2--0
- **Homepage**: https://github.com/genome/mendelscan
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mendelscan/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genome/mendelscan
- **Stars**: N/A
### Original Help Text
```text
USAGE: java -jar MendelScan.jar score [VCF] OPTIONS
	OPTIONS:
	--vep-file	Variant annotation in VEP format
	--ped-file	Pedigree file in 6-column tab-delimited format
	--gene-file	A list of gene expression values for tissue of interest
	--output-file	Output file to contain human-friendly scored variants
	--output-vcf	Output file to contain scored variants in VCF format
	--inheritance	Presumed model of inheritance: dominant, recessive, x-linked [dominant]

	Segregation Scoring: Segregation score multiplied by these values for dominant/recessive
	--seg-score-case-ref	A case sample was called reference/wild-type (0.50/0.10)
	--seg-score-case-het	A case sample was called heterozygous (NA/0.50)
	--seg-score-case-hom	A case sample was called homozygous variant (0.80/NA)
	--seg-score-control-het	A case sample was called heterozygous (0.10/NA)
	--seg-score-control-hom	A case sample was called homozygous variant (0.01/0.10)
\t--min-read-depth	Minimum read depth to consider a confident genotype call [20]
	--max-vaf-for-ref	Maximum non-ref (variant) allele frequency at ref site to count as ref [0.05]
	--min-vaf-to-recall	Minimum VAF at which a reference genotype will be considered het. To disable recall, set to 1.01 [0.20]

	Population Scoring: Population score for these classes defined by dbSNP information
	--pop-score-novel	Variant is not present in dbSNP according to VCF (1.00)
	--pop-score-mutation	Variant from mutation (OMIM) or locus-specific databases (0.95)
	--pop-score-known	Variant known to dbSNP but no mutation or GMAF info (0.60)
	--pop-score-rare	Variant in dbSNP with GMAF < 0.01 (0.20)
	--pop-score-uncommon	Variant in dbSNP with GMAF 0.01-0.05 (0.02)
	--pop-score-common	Variant in dbSNP with GMAF >= 0.05 (0.01)

	Annotation Scoring: Annotation score based on canonical or most-damaging VEP consequence
	--anno-score-1	Score for intergenic mutations [0.01]
	--anno-score-2	Score for intronic mutations [0.01]
	--anno-score-3	Score for downstream mutations [0.01]
	--anno-score-4	Score for upstream mutations [0.01]
	--anno-score-5	Score for UTR mutations [0.01]
	--anno-score-6	Score for ncRNA mutations [0.01]
	--anno-score-7	Score for miRNA mutations [0.01]
	--anno-score-8	Score for synonymous coding mutations [0.05]
	--anno-score-9	Score for splice region mutations [0.20]
	--anno-score-10	Score for nonstop mutations [1.00]
	--anno-score-11	Score for missense mutations not predicted damaging [0.80]
	--anno-score-12	Score for missense mutations damaging by 1/3 algorithms [0.95]
	--anno-score-13	Score for missense mutations damaging by 2/3 algorithms [0.95]
	--anno-score-14	Score for missense mutations damaging by 3/3 algorithms [0.95]
	--anno-score-15	Score for essential splice site mutations [1.00]
	--anno-score-16	Score for frameshift mutations [1.00]
	--anno-score-17	Score for nonsense mutations [1.00]
```


## mendelscan_rhro

### Tool Description
MendelScan RHRO analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/mendelscan:v1.2.2--0
- **Homepage**: https://github.com/genome/mendelscan
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE: java -jar MendelScan.jar rhro [VCF] OPTIONS
	OPTIONS:
	--ped-file	Pedigree file in 6-column tab-delimited format
	--centromere-file	A tab-delimited, BED-like file indicating centromere locations by chromosome	--output-file	Output file to contain informative variants
	--output-windows	Output file to contain RHRO windows. Otherwise they print to STDOUT
	--inheritance	Presumed model of inheritance: dominant, recessive, x-linked [dominant]
```


## mendelscan_sibd

### Tool Description
Calculates IBD segments for sibling pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mendelscan:v1.2.2--0
- **Homepage**: https://github.com/genome/mendelscan
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE: java -jar MendelScan.jar sibd [FIBD] OPTIONS
	FIBD: The uncompressed FastIBD output file from BEAGLE
	OPTIONS:
	--ped-file	Pedigree file in 6-column tab-delimited format
	--markers-file	Markers file in BEAGLE format
	--centromere-file	A tab-delimited, BED-like file indicating centromere locations by chromosome	--output-file	Output file to contain IBD markers with chromosomal coordinates
	--output-windows	Output file to contain RHRO windows. Otherwise they print to STDOUT
	--ibd-score-threshold	Maximum Beagle FastIBD score below which segments will be used [10e-10]
	--window-resolution	Window size in base pairs to use for SIBD region binning [100000]
	--inheritance	Presumed model of inheritance: dominant, recessive, x-linked [dominant]
```


## mendelscan_trio

### Tool Description
MendelScan trio analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/mendelscan:v1.2.2--0
- **Homepage**: https://github.com/genome/mendelscan
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE: java -jar MendelScan.jar trio [VCF] OPTIONS
	OPTIONS:
	--vep-file	Variant annotation in VEP format
	--ped-file	Pedigree file in 6-column tab-delimited format
	--gene-file	A list of gene expression values for tissue of interest
	--output-file	Output file to contain summary report
	--output-recessive	Output file to contain scored variants in VCF format
	--output-denovo	Output file for possible de novo variants
```

