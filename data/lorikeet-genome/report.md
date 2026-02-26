# lorikeet-genome CWL Generation Report

## lorikeet-genome_lorikeet

### Tool Description
Variant calling and strain genotyping analysis for metagenomics

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Total Downloads**: 38.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rhysnewell/Lorikeet
- **Stars**: N/A
### Original Help Text
```text
Variant calling and strain genotyping analysis for metagenomics

Usage: lorikeet <subcommand> ...

Main subcommands:
	call      	Performs variant calling on the provides genomes
	consensus 	Creates consensus genomes for each input reference and for each sample

Utility subcommands:
	summarise 	Calculate microdiversity statistics for a given set of VCF files
	shell-completion  	Generate shell completion scripts

Experimental subcommands:
	genotype  	Report strain-level genotypes and abundances from metagenomes

Other options:
	-V, --version	Print version information

Rhys J. P. Newell <rhys.newell near hdr.qut.edu.au>
```


## lorikeet-genome_lorikeet call

### Tool Description
Perform read mapping and variant calling using local reassembly of active regions

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

### Original Help Text
```text
lorikeet call
              Perform read mapping and variant calling using local reassembly of active regions

Example: Map paired reads to a reference and generate genotypes

  lorikeet call --coupled read1.fastq.gz read2.fastq.gz --reference assembly.fna --threads 10 --kmer-sizes 17 25

Example: Perform read read mapping and variant calling on an entire directory of genomes and save the bam files:

  lorikeet genotype --bam-files my.bam --longread-bam-files my-longread.bam --genome-fasta-directory genomes/ -x fna
    --bam-file-cache-directory saved_bam_files --output-directory lorikeet_out/ --threads 10 --kmer-sizes 17 25

See lorikeet genotype --full-help for further options and further detail.
```


## lorikeet-genome_lorikeet genotype

### Tool Description
Report strain-level genotypes and abundances based on variant read mappings

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

### Original Help Text
```text
lorikeet genotype
              *EXPERIMENTAL* Report strain-level genotypes and abundances based on variant read mappings

Example: Map paired reads to a reference and generate genotypes

  lorikeet genotype --coupled read1.fastq.gz read2.fastq.gz --reference assembly.fna --threads 10 --kmer-sizes 10 25

Example: Generate strain-level genotypes from read mappings compared to reference from a sorted BAM file and plots the results:

  lorikeet genotype --bam-files my.bam --longread-bam-files my-longread.bam --genome-fasta-directory genomes/ -x fna
    --bam-file-cache-directory saved_bam_files --output-directory lorikeet_out/ --threads 10

See lorikeet genotype --full-help for further options and further detail.
```


## lorikeet-genome_lorikeet consensus

### Tool Description
Consensus caller for lorikeet

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

### Original Help Text
```text
error: the following required arguments were not provided:
  --read1 <read1>...
  --read2 <read2>...
  --coupled <coupled>...
  --interleaved <interleaved>...
  --single <single>...
  --longreads <longreads>...
  --longread-bam-files <longread-bam-files>...
  --genome-fasta-files <genome-fasta-files>...
  --genome-fasta-directory <genome-fasta-directory>

Usage: lorikeet consensus --read1 <read1>... --read2 <read2>... --coupled <coupled>... --interleaved <interleaved>... --single <single>... --longreads <longreads>... --longread-bam-files <longread-bam-files>... --genome-fasta-files <genome-fasta-files>... --genome-fasta-directory <genome-fasta-directory>

For more information, try '--help'.
```


## lorikeet-genome_lorikeet evolve

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
error: unrecognized subcommand 'evolve'

Usage: lorikeet [OPTIONS] [COMMAND]

For more information, try '--help'.
```


## lorikeet-genome_lorikeet shell-completion

### Tool Description
Generate a shell completion script for lorikeet

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

### Original Help Text
```text
Generate a shell completion script for lorikeet

Usage: lorikeet shell-completion [OPTIONS] --output-file <output-file> --shell <shell>

Options:
  -v, --verbose                    Print extra debug logging information
      --quiet                      Unless there is an error, do not print logging information
  -o, --output-file <output-file>  
      --shell <shell>              [possible values: bash, elvish, fish, powershell, zsh]
  -h, --help                       Print help
```

