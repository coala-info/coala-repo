# metabuli CWL Generation Report

## metabuli_classify

### Tool Description
By Jaebeom Kim <jbeom0731@gmail.com>

### Metadata
- **Docker Image**: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
- **Homepage**: https://github.com/steineggerlab/Metabuli
- **Package**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metabuli/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/steineggerlab/Metabuli
- **Stars**: N/A
### Original Help Text
```text
usage: metabuli classify <i:query file(s)> <i:database directory> <o:output directory> <job ID>  [options]
 By Jaebeom Kim <jbeom0731@gmail.com>
options: prefilter:              
 --mask INT               Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1: with low complexity masking [0]
 --mask-prob FLOAT        Mask sequences is probablity is above threshold [0.900]
misc:                   
 --seq-mode INT           Single-end: 1, Paired-end: 2, Long read: 3 [2]
 --min-score FLOAT        Min. sequence similarity score (0.0-1.0) [0.000]
 --min-cov FLOAT          Min. query coverage (0.0-1.0) [0.000]
 --min-cons-cnt INT       Min. number of consecutive matches for prokaryote/virus classification [4]
 --min-cons-cnt-euk INT   Min. number of consecutive matches for eukaryote classification [9]
 --min-sp-score FLOAT     Min. score for species- or lower-level classification. [0.000]
 --hamming-margin INT     It allows extra Hamming distance than the minimum distance. [0]
 --taxonomy-path STR      Directory where the taxonomy dump files are stored []
 --max-ram INT            RAM usage in GiB [128]
 --match-per-kmer INT     Num. of matches per query k-mer. Larger values assign more memory for storing k-mer matches.  [4]
 --accession-level INT    Build or search a database for accession-level classification [0]
 --tie-ratio FLOAT        Best * --tie-ratio is considered as a tie [0.950]
 --skip-redundancy INT    Not storing k-mer's redundancy. [0]
 --lineage INT            Print lineage information [0]
 --validate-input INT     Validate format of input FASTA/FASTQ file(s) [0]
 --validate-db INT        Validate the database. It checks if all required files are present and if the k-mer count is consistent. [0]
common:                 
 --threads INT            Number of CPU-cores used (all by default) [20]

references:
```

