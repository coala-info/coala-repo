# merqury CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| merqury_merqury.sh | PASS | SARS-CoV-2 genome with a meryl k=21 database of real amplicon reads: QV 35.38 (equals merfin QV), completeness 97.5%, spectra plots and histograms written; fixed meryl inputs to Directory and outputs to files plus directories |

## merqury_merqury.sh

### Tool Description
Generates k-mer counts for read sets and assemblies to assess assembly quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/merqury:1.3--hdfd78af_4
- **Homepage**: https://github.com/marbl/merqury
- **Package**: https://anaconda.org/channels/bioconda/packages/merqury/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: merqury.sh <read-db.meryl> [<mat.meryl> <pat.meryl>] <asm1.fasta> [asm2.fasta] <out>
	<read-db.meryl>	: k-mer counts of the read set
	<mat.meryl>		: k-mer counts of the maternal haplotype (ex. mat.hapmer.meryl)
	<pat.meryl>		: k-mer counts of the paternal haplotype (ex. pat.hapmer.meryl)
	<asm1.fasta>	: Assembly fasta file (ex. pri.fasta, hap1.fasta or maternal.fasta)
	[asm2.fasta]	: Additional fasta file (ex. alt.fasta, hap2.fasta or paternal.fasta)
	*asm1.meryl and asm2.meryl will be generated. Avoid using the same names as the hap-mer dbs
	<out>		: Output prefix
Arang Rhie, 2020-01-29. arrhie@gmail.com
```


## Metadata
- **Skill**: generated
