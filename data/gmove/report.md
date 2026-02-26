# gmove CWL Generation Report

## gmove

### Tool Description
Gene modelling using various evidence.

### Metadata
- **Docker Image**: quay.io/biocontainers/gmove:1.3--h9948957_0
- **Homepage**: https://github.com/institut-de-genomique/Gmove
- **Package**: https://anaconda.org/channels/bioconda/packages/gmove/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmove/overview
- **Total Downloads**: 713
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/institut-de-genomique/Gmove
- **Stars**: N/A
### Original Help Text
```text
Gmove (Gene MOdeling using Various Evidence)
Command line gmove -help 
Wed Feb 25 17:28:07 2026

--------------------------------------------------------------------------------------------
gmove - Gene modelling using various evidence.

Usage : gmove -f <reference sequence> {Options}
INPUT FILES
	*-f <file>		: fasta file which contains genome sequence(s).
	--rna <file>		: rna file in gff (expect tag 'exon' or 'HSP' in column 3)
	--longReads <file>		: rna file in gff from long reads sequencing (expect tag 'exon' or 'HSP' in column 3)
	--prot <file>		: prot file in gff (expect tag 'exon' or 'HSP' in column 3)
	--annot <file>		: annotation file in gff (expect tag 'CDS' or 'UTR' in column 3)
	--abinitio <file>	: ab initio file in gff (expect tag 'CDS' or 'UTR' in column 3)
	--exclude_introns <file>: tabular file that contains introns to remove
	                          [FORMAT 4 columns: seqname start end strand]
	                          [separator is tabulation AND strand is '+' or '-' only]

OUTPUT FILES
	-o <folder>		: output folder, by default ./out 
	--raw			: output raw data 

	--score			: Keep the model with the highest score per connected component, otherwise keep model with the longest CDS
	-y <int>		: genetic code (1, 6 or 23), default is 1.
	--ratio			: ratio CDS/UTR min 80% de CDS
	-S			: do not output single exon models.
	-e <int>		: minimal size of exons, default is 9 nucleotides.
	-i <int>		: minimal size of introns, default is 9 nucleotides.
	-m <int>		: maximal size of introns, default is 50.000 nucleotides.
	-P <int>		: maximal number of paths inside a connected component, default is 10,000.
	-x <int>		: size of regions where to find splice site around covtigs boundaries, default is 0.
	-b <int>		: number of nucleotides around exons boundaries where to find start and stop codons, default is 30.
	-t			: gtf format annotation file - default is gff3
	--cds			: min size CDS, by default 100 
	-v			: verbose
	-h			: this help
--------------------------------------------------------------------------------------------
```

