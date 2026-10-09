# lorikeet-genome CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lorikeet-genome_lorikeet_call | PASS |  |
| lorikeet-genome_lorikeet_consensus | PASS |  |
| lorikeet-genome_lorikeet_genotype | Failed | tool bug: lorikeet genotype panics on every run (clap argument mismatch for min-variant-depth-for-genotyping) |
| lorikeet-genome_lorikeet_summarise | PASS |  |

## lorikeet-genome_lorikeet_call

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

## lorikeet-genome_lorikeet_genotype

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

## lorikeet-genome_lorikeet_consensus

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

## lorikeet-genome_lorikeet_summarise

### Tool Description
Summarizes ANI values of a given set of VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
- **Homepage**: https://github.com/rhysnewell/Lorikeet
- **Package**: https://anaconda.org/channels/bioconda/packages/lorikeet-genome/overview
- **Validation**: PASS

### Original Help Text
```text
Summarizes ANI values of a given set of VCF files

Usage: lorikeet summarise [OPTIONS]

Options:
      --full-help                                          
      --full-help-roff                                     
  -i, --vcfs <vcfs>...                                     
  -o, --output-directory <output>                          [default: ./]
  -t, --threads <threads>                                  [default: 8]
      --qual-by-depth-filter <qual-by-depth-filter>        [default: 25.0]
      --qual-threshold <qual-threshold>                    [default: 150.0]
      --depth-per-sample-filter <depth-per-sample-filter>  [default: 5]
  -v, --verbose                                            
  -h, --help                                               Print help
```

## Metadata
- **Skill**: generated
