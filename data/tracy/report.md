# tracy CWL Generation Report

## tracy_index

### Tool Description
Index a genome for tracy

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Total Downloads**: 76.3K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/gear-genomics/tracy
- **Stars**: N/A
### Original Help Text
```text
Usage: tracy index [OPTIONS] genome.fa.gz

Generic options:
  -? [ --help ]                        show help message
  -o [ --output ] arg (="genome.fm9")  output file
```


## tracy_basecall

### Tool Description
Basecalling of Sanger trace files

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracy basecall [OPTIONS] trace.ab1

Generic options:
  -? [ --help ]                       show help message
  -p [ --pratio ] arg (=0.330000013)  peak ratio to call a base
  -f [ --format ] arg (=json)         output format [json|tsv|fasta|fastq]
  -y [ --otype ] arg (=primary)       fasta/fastq sequence [primary|secondary|c
                                      onsensus]
  -t [ --trim ] arg (=0)              trimming stringency [1:9], 0: use 
                                      trimLeft and trimRight
  -q [ --trimLeft ] arg (=0)          trim size left
  -u [ --trimRight ] arg (=0)         trim size right
  -o [ --output ] arg (="out.json")   basecalling output
```


## tracy_align

### Tool Description
Align Sanger trace files to a reference genome or wildtype trace

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracy align [OPTIONS] -r genome.fa trace.ab1

Generic options:
  -? [ --help ]                       show help message
  -r [ --reference ] arg              (gzipped) fasta or wildtype ab1 file
  -p [ --pratio ] arg (=0.330000013)  peak ratio to call base
  -k [ --kmer ] arg (=15)             kmer size to anchor trace
  -s [ --support ] arg (=3)           min. kmer support
  -i [ --maxindel ] arg (=1000)       max. indel size in Sanger trace

Alignment options:
  -g [ --gapopen ] arg (=-10)         gap open
  -e [ --gapext ] arg (=-4)           gap extension
  -m [ --match ] arg (=3)             match
  -n [ --mismatch ] arg (=-5)         mismatch

Trimming options:
  -t [ --trim ] arg (=0)              trimming stringency [1:9], 0: use 
                                      trimLeft and trimRight
  -q [ --trimLeft ] arg (=50)         trim size left
  -u [ --trimRight ] arg (=50)        trim size right

Output options:
  -l [ --linelimit ] arg (=60)        alignment line length
  -o [ --outprefix ] arg (=out)       output prefix
```


## tracy_decompose

### Tool Description
Decompose Sanger chromatogram trace files to identify variants or reference alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracy decompose [OPTIONS] trace.ab1

Generic options:
  -? [ --help ]                       show help message
  -r [ --genome ] arg                 (gzipped) fasta or wildtype ab1 file
  -p [ --pratio ] arg (=0.330000013)  peak ratio to call base
  -k [ --kmer ] arg (=15)             kmer size
  -s [ --support ] arg (=3)           min. kmer support
  -i [ --maxindel ] arg (=1000)       max. indel size in Sanger trace
  -a [ --annotate ] arg               annotate variants [homo_sapiens|homo_sapi
                                      ens_hg19|mus_musculus|danio_rerio|...]
  -v [ --callVariants ]               call variants in trace

Alignment options:
  -g [ --gapopen ] arg (=-10)         gap open
  -e [ --gapext ] arg (=-4)           gap extension
  -m [ --match ] arg (=3)             match
  -n [ --mismatch ] arg (=-5)         mismatch

Trimming options:
  -t [ --trim ] arg (=0)              trimming stringency [1:9], 0: use 
                                      trimLeft and trimRight
  -q [ --trimLeft ] arg (=50)         trim size left
  -u [ --trimRight ] arg (=50)        trim size right

Output options:
  -l [ --linelimit ] arg (=60)        alignment line length
  -o [ --outprefix ] arg (=out)       output prefix
```


## tracy_consensus

### Tool Description
Generate a consensus sequence from two trace files

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracy consensus [OPTIONS] trace1.ab1 trace2.ab1

Generic options:
  -? [ --help ]                       show help message
  -b [ --label ] arg (=Consensus)     sample label
  -p [ --pratio ] arg (=0.330000013)  peak ratio to call base

Alignment options:
  -g [ --gapopen ] arg (=-10)         gap open
  -e [ --gapext ] arg (=-4)           gap extension
  -m [ --match ] arg (=3)             match
  -n [ --mismatch ] arg (=-5)         mismatch

Trimming options:
  -t [ --trim ] arg (=0)              trimming stringency [1:9], 0: use 
                                      trimLeft and trimRight
  -q [ --trimLeft1 ] arg (=50)        trim size left (1st trace)
  -u [ --trimRight1 ] arg (=50)       trim size right (1st trace)
  -r [ --trimLeft2 ] arg (=50)        trim size left (2nd trace)
  -s [ --trimRight2 ] arg (=50)       trim size right (2nd trace)

Output options:
  -l [ --linelimit ] arg (=60)        alignment line length
  -o [ --outprefix ] arg (=out)       output prefix
  -i [ --intersect ]                  use only trace intersection for consensus
  -a [ --iupac ]                      use IUPAC nucleotide code in consensus 
                                      (max. 2 nucleotides)
```


## tracy_assemble

### Tool Description
Assemble trace files into a consensus sequence, optionally guided by a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
- **Homepage**: https://github.com/gear-genomics/tracy
- **Package**: https://anaconda.org/channels/bioconda/packages/tracy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracy assemble [OPTIONS] trace1.ab1 trace2.ab1 ...

Generic options:
  -? [ --help ]                       show help message
  -r [ --reference ] arg              reference-guided assembly (optional)
  -p [ --pratio ] arg (=0.330000013)  peak ratio to call base
  -t [ --trim ] arg (=4)              trimming stringency [1:9], 0: disable 
                                      trimming
  -f [ --fracmatch ] arg (=0.5)       min. fraction of matches [0:1]

Alignment options:
  -g [ --gapopen ] arg (=-10)         gap open
  -e [ --gapext ] arg (=-4)           gap extension
  -m [ --match ] arg (=3)             match
  -n [ --mismatch ] arg (=-5)         mismatch

Output options:
  -d [ --called ] arg (=0.100000001)  fraction of traces required for consensus
  -o [ --outprefix ] arg (=out)       output prefix
  -a [ --format ] arg (=fasta)        consensus output format [fasta|fastq]
  -i [ --inccons ]                    include consensus in FASTA align
  -j [ --incref ]                     include reference in consensus 
                                      computation (req. --reference)
```


## Metadata
- **Skill**: not generated
