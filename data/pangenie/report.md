# pangenie CWL Generation Report

## pangenie

### Tool Description
FAIL to generate CWL: pangenie not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
- **Homepage**: https://github.com/eblerjana/pangenie
- **Package**: https://anaconda.org/channels/bioconda/packages/pangenie/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pangenie/overview
- **Total Downloads**: 357
- **Last updated**: 2025-10-20
- **GitHub**: https://github.com/eblerjana/pangenie
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pangenie not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pangenie not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pangenie_PanGenie-index

### Tool Description
PanGenie - genotyping based on kmer-counting and known haplotype sequences. Indexing step.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
- **Homepage**: https://github.com/eblerjana/pangenie
- **Package**: https://anaconda.org/channels/bioconda/packages/pangenie/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

program: PanGenie - genotyping based on kmer-counting and known haplotype sequences.
author: Jana Ebler

version: v4.2.1
usage: 
PanGenie-index [options] -r <reference.fa> -v <variants.vcf> -o <index-prefix>

options:
	-e VAL	size of hash used by jellyfish (default: 3000000000).
	-k VAL	kmer size (default: 31).
	-o VAL	prefix of the output files. NOTE: the given path must not include non-existent folders.
	-r VAL	reference genome in FASTA format. NOTE: INPUT FASTA FILE MUST NOT BE COMPRESSED.
	-t VAL	number of threads to use for kmer-counting (default: 1).
	-v VAL	variants in VCF format. NOTE: INPUT VCF FILE MUST NOT BE COMPRESSED.

Error: option -r is mandatory.
```

## pangenie_PanGenie

### Tool Description
Genotyping based on kmer-counting and known haplotype sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
- **Homepage**: https://github.com/eblerjana/pangenie
- **Package**: https://anaconda.org/channels/bioconda/packages/pangenie/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

program: PanGenie - genotyping based on kmer-counting and known haplotype sequences.
author: Jana Ebler

version: v4.2.1
usage: 
PanGenie [options] -f <index-prefix> -i <reads.fa/fq> -o <outfile-prefix>
PanGenie [options] -i <reads.fa/fq> -r <reference.fa> -v <variants.vcf> -o <outfile-prefix>

options:
	-a VAL	sample subsets of paths of this size (default: 0).
	-b VAL	effective population size for sampling step. (default: 0.01).
	-c	count all read kmers instead of only those located in graph
	-d	write sampled panel to additional output VCF.
	-e VAL	size of hash used by jellyfish (default: 3000000000).
	-f VAL	Filename prefix of files computed by PanGenie-index (i.e. option -o used with PanGenie-index).
	-g	run genotyping (Forward backward algorithm, default behaviour)
	-i VAL	sequencing reads in FASTA/FASTQ format or Jellyfish database in jf format. NOTE: INPUT FASTA/Q FILE MUST NOT BE COMPRESSED.
	-j VAL	number of threads to use for kmer-counting (default: 1).
	-k VAL	kmer size (default: 31).
	-o VAL	prefix of the output files. NOTE: the given path must not include non-existent folders (default: result).
	-p	run phasing (Viterbi algorithm). Experimental feature
	-r VAL	reference genome in FASTA format. NOTE: INPUT FASTA FILE MUST NOT BE COMPRESSED.
	-s VAL	name of the sample (will be used in the output VCFs) (default: sample).
	-t VAL	number of threads to use for core algorithm. Largest number of threads possible is the number of chromosomes given in the VCF (default: 1).
	-u	output genotype ./. for variants not covered by any unique kmers
	-v VAL	variants in VCF format. NOTE: INPUT VCF FILE MUST NOT BE COMPRESSED.
	-w	instead of writing an output vcf, serialize genotyping results.
	-x VAL	to which size the input panel shall be reduced. (default: 0).
	-y VAL	Penality used for already selected alleles in sampling step. (default: 5).

Error: one of the options -f and -v must be used.
```

## pangenie_PanGenie-vcf

### Tool Description
Genotyping based on kmer-counting and known haplotype sequences using serialized genotyping results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
- **Homepage**: https://github.com/eblerjana/pangenie
- **Package**: https://anaconda.org/channels/bioconda/packages/pangenie/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

program: PanGenie - genotyping based on kmer-counting and known haplotype sequences.
author: Jana Ebler

version: v4.2.1
usage: 
PanGenie-vcf [options] -f <index-prefix> -z <outname_genotyping.cereal> -o <outfile-prefix>

options:
	-f VAL	filename prefix of the index files (i.e. option -o used with PanGenie-index).
	-g	run genotyping (only set if used with PanGenie genotyping)
	-o VAL	prefix of the output files. NOTE: the given path must not include non-existent folders (default: result).
	-p	run phasing (only set if used with PanGenie genotyping)
	-s VAL	name of the sample (will be used in the output VCFs) (default: sample).
	-u	output genotype ./. for variants not covered by any unique kmers
	-z VAL	serialized genotyping results (produced by PanGenie run with parameter -w).

Error: option -z is mandatory.
```

