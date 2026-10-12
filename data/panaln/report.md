# panaln CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| panaln_align | Failed | tool bug: panaln align crashes (index out of boundary) on exact reads for genomes of 30 kb to 47 Mb and writes a SAM header only |
| panaln_combine | PASS |  |
| panaln_index | Not completed | index files are created, but they cannot be confirmed because panaln align crashes on them |

## panaln_combine

### Tool Description
Generate Pangenome by combining FASTA and VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
- **Homepage**: https://github.com/Lilu-guo/Panaln
- **Package**: https://anaconda.org/channels/bioconda/packages/panaln/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panaln/overview
- **Total Downloads**: 131
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Lilu-guo/Panaln
- **Stars**: N/A
### Original Help Text
```text
**** Generate Pangenome **** 
Usage: panaln combine -s <input.fasta> -v <input.vcf> -b <basename> 

Usage: panaln combine -s <input.fasta> -v <input.vcf> -b <basename>
```


## panaln_index

### Tool Description
Index a pan-genome file

### Metadata
- **Docker Image**: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
- **Homepage**: https://github.com/Lilu-guo/Panaln
- **Package**: https://anaconda.org/channels/bioconda/packages/panaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: panaln index -p <input.pan>
```


## panaln_align

### Tool Description
Align fastq sequences using panaln

### Metadata
- **Docker Image**: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
- **Homepage**: https://github.com/Lilu-guo/Panaln
- **Package**: https://anaconda.org/channels/bioconda/packages/panaln/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: panaln align -x <index_basename> -f <input.fastq> -s <output.sam> 

Usage: panaln align -x <index_basename> -f <input.fastq> -s <output.sam>
```


## Metadata
- **Skill**: generated
