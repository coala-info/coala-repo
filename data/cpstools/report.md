# cpstools CWL Generation Report

## cpstools_sub-command

### Tool Description
A collection of tools for analyzing sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-08-08
- **GitHub**: https://github.com/Xwb7533/CPStools
- **Stars**: N/A
### Original Help Text
```text
usage: cpstools [-h] [-v]
                {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth} ...
cpstools: error: argument {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth}: invalid choice: 'sub-command' (choose from gbcheck, info, Seq, IR, Pi, RSCU, SSRs, convert, LSRs, phy, KaKs, exc, GC, depth)
```


## cpstools_gbcheck

### Tool Description
Check GenBank files for consistency.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools gbcheck [-h] [-r REF_FILE] -i TEST_FILE

options:
  -h, --help            show this help message and exit
  -r, --ref_file REF_FILE
                        reference GenBank file
  -i, --test_file TEST_FILE
                        testing GenBank file
```


## cpstools_difference

### Tool Description
A collection of tools for analyzing and manipulating sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools [-h] [-v]
                {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth} ...
cpstools: error: argument {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth}: invalid choice: 'difference' (choose from gbcheck, info, Seq, IR, Pi, RSCU, SSRs, convert, LSRs, phy, KaKs, exc, GC, depth)
```


## cpstools_info

### Tool Description
Show information about a genbank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools info [-h] -i INPUT_FILE

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Input genbank format file
```


## cpstools_Seq

### Tool Description
Sequence manipulation tool

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools Seq [-h] -d WORK_DIR -f INFO_FILE [-m {SSC,LSC,RP}]

options:
  -h, --help            show this help message and exit
  -d, --work_dir WORK_DIR
                        Input directory of fasta files
  -f, --info_file INFO_FILE
                        file of the information of the fasta file four regions
  -m, --mode {SSC,LSC,RP}
                        Mode: SSC for adjust_SSC_forward, LSC for
                        adjust_start_to_LSC, RP for adjust sequence to
                        reverse_complement
```


## cpstools_IR

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools IR [-h] -i INPUT_FILE

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        fasta/GenBank format file
```


## cpstools_Pi

### Tool Description
Calculate pairwise pi values for a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools Pi [-h] -d WORK_DIR [-m MAFFT_PATH]

options:
  -h, --help            show this help message and exit
  -d, --work_dir WORK_DIR
                        Input directory of genbank files
  -m, --mafft_path MAFFT_PATH
                        Path to MAFFT executable if not in environment path
```


## cpstools_RSCU

### Tool Description
Calculate RSCU values for CDS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools RSCU [-h] -d WORK_DIR [-l FILTER_LENGTH]

options:
  -h, --help            show this help message and exit
  -d, --work_dir WORK_DIR
                        Input directory of genbank files
  -l, --filter_length FILTER_LENGTH
                        CDS filter length, default is 300
```


## cpstools_SSRs

### Tool Description
Find Simple Sequence Repeats (SSRs) in GenBank files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools SSRs [-h] -i INPUT_FILE [-k KMER_LENGTH]

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        GenBank format file
  -k, --kmer_length KMER_LENGTH
                        SSRs length, default is 10,6,5,4,4,4
```


## cpstools_convert

### Tool Description
Convert genbank format files to other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools convert [-h] -d INPUT_DIR -m {fasta,mVISTA,tbl,ge2gb}

options:
  -h, --help            show this help message and exit
  -d, --input_dir INPUT_DIR
                        Input path of genbank file
  -m, --mode {fasta,mVISTA,tbl,ge2gb}
                        Mode: fasta for converse genbank format file into
                        fasta format file; mVISTA for converse genbank format
                        file into mVISTA format file; tbl for converse genbank
                        format file into tbl format file
```


## cpstools_LSRs

### Tool Description
Process GenBank files for LSRs

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools LSRs [-h] -i INPUT_FILE

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        GenBank format file
```


## cpstools_phy

### Tool Description
Phylogenetic analysis tools

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools phy [-h] -d INPUT_DIR -m {cds,pro}

options:
  -h, --help            show this help message and exit
  -d, --input_dir INPUT_DIR
                        Input the directory of genbank files
  -m, --mode {cds,pro}  Mode: cds for common cds sequences; pro for common
                        protein sequences
```


## cpstools_phylogenetic

### Tool Description
A collection of tools for phylogenetic analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools [-h] [-v]
                {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth} ...
cpstools: error: argument {gbcheck,info,Seq,IR,Pi,RSCU,SSRs,convert,LSRs,phy,KaKs,exc,GC,depth}: invalid choice: 'phylogenetic' (choose from gbcheck, info, Seq, IR, Pi, RSCU, SSRs, convert, LSRs, phy, KaKs, exc, GC, depth)
```


## cpstools_KaKs

### Tool Description
KaKs calculator

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools KaKs [-h] -i INPUT_REFERENCE [-m MODE]

options:
  -h, --help            show this help message and exit
  -i, --input_reference INPUT_REFERENCE
                        Input path of reference genbank file
  -m, --mode MODE       KaKs calculator mode
```


## cpstools_exc

### Tool Description
Extracts gene sequences from a reference genbank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools exc [-h] -i INPUT_FILE -r REF_FILE -n GENE_NAME

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Input path of reference genbank file
  -r, --ref_file REF_FILE
                        Input path of reference genbank file
  -n, --gene_name GENE_NAME
                        Input path of reference genbank file
```


## cpstools_GC

### Tool Description
GC content calculation for genbank/fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools GC [-h] -i INPUT_FILE

options:
  -h, --help            show this help message and exit
  -i, --input_file INPUT_FILE
                        Input path of genbank/fasta format file
```


## cpstools_depth

### Tool Description
Calculate sequencing depth for paired-end reads against a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Xwb7533/CPStools
- **Package**: https://anaconda.org/channels/bioconda/packages/cpstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cpstools depth [-h] -i INPUT_FASTA -1 P1 -2 P2 [-o OUTPUT] [-t THREADS]
                      [-b BLOCK_SIZE]

options:
  -h, --help            show this help message and exit
  -i, --input_fasta INPUT_FASTA
                        Input/reference fasta file
  -1, --p1 P1           Paired-End fastq file1
  -2, --p2 P2           Paired-End fastq file2
  -o, --output OUTPUT   Output directory (default: same as --p1)
  -t, --threads THREADS
                        Threads (default: 10)
  -b, --block_size BLOCK_SIZE
                        Block size (default: 2000)
```

