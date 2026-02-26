# vclust CWL Generation Report

## vclust_deduplicate

### Tool Description
Output FASTA file with unique, nonredundant sequences, removing duplicates and their reverse complements

### Metadata
- **Docker Image**: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
- **Homepage**: https://github.com/refresh-bio/vclust
- **Package**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/refresh-bio/vclust
- **Stars**: N/A
### Original Help Text
```text
usage: vclust deduplicate [-i <file> [<file> ...]] -o <file> [--add-prefixes [<str> ...]]
                          [--gzip-output] [--gzip-level <int>] [-t <int>] [-v <int>] [-h]

required arguments:
  -i, --in <file> [<file> ...]  Space-separated input FASTA files (gzipped or uncompressed)
  -o, --out <file>              Output FASTA file with unique, nonredundant sequences, removing
                                duplicates and their reverse complements

options:
  --add-prefixes [<str> ...]    Add prefixes to sequence IDs. Without any values, prefixes are set
                                to input file names. Provide space-separated prefixes to override.
                                Default: prefixes are disabled [False]
  --gzip-output                 Compress the output FASTA file with gzip [False]
  --gzip-level <int>            Compression level for gzip (1-9) [4]
  -t, --threads <int>           Number of threads [20]
  -v <int>                      Verbosity level [1]:
                                0: Errors only
                                1: Info
                                2: Debug
  -h, --help                    Show this help message and exit

Examples:
vclust deduplicate -i refseq.fna genbank.fna -o nr.fna --add-prefixes
vclust deduplicate -i refseq.fna genbank.fna -o nr.fna.gz --gzip-out --add-prefixes
```


## vclust_prefilter

### Tool Description
vclust prefilter

### Metadata
- **Docker Image**: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
- **Homepage**: https://github.com/refresh-bio/vclust
- **Package**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vclust prefilter -i <file> -o <file> [-k <int>] [--min-kmers <int>] [--min-ident <float>]
                        [--batch-size <int>] [--kmers-fraction <float>] [--max-seqs <int>]
                        [-t <int>] [-v <int>] [-h]

required arguments:
  -i, --in <file>           Input FASTA file or directory of files (gzipped or uncompressed)
  -o, --out <file>          Output filename

options:
  -k, --k <int>             Size of k-mer for Kmer-db [25]
  --min-kmers <int>         Minimum number of shared k-mers between two genomes [20]
  --min-ident <float>       Minimum sequence identity (0-1) between two genomes. Calculated based on
                            the shorter sequence [0.7]
  --batch-size <int>        Process a multifasta file in smaller batches of <int> FASTA sequences.
                            This option reduces memory at the expense of speed. By default, no batch
                            [0]
  --kmers-fraction <float>  Fraction of k-mers to analyze in each genome (0-1). A lower value
                            reduces RAM usage and speeds up processing. By default, all k-mers [1.0]
  --max-seqs <int>          Maximum number of sequences allowed to pass the prefilter per query.
                            Only the sequences with the highest identity to the query are reported.
                            This option reduces RAM usage and speeds up processing (affects
                            sensitivity). By default, all sequences that pass the prefilter are
                            reported [0]
  -t, --threads <int>       Number of threads [20]
  -v <int>                  Verbosity level [1]:
                            0: Errors only
                            1: Info
                            2: Debug
  -h, --help                Show this help message and exit
```


## vclust_align

### Tool Description
Align genome pairs

### Metadata
- **Docker Image**: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
- **Homepage**: https://github.com/refresh-bio/vclust
- **Package**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vclust align -i <file> -o <file> [--filter <file>] [--filter-threshold <float>]
                    [--outfmt <str>] [--out-aln <file>] [--out-ani <float>] [--out-tani <float>]
                    [--out-gani <float>] [--out-qcov <float>] [--out-rcov <float>] [--mal <int>]
                    [--msl <int>] [--mrd <int>] [--mqd <int>] [--reg <int>] [--aw <int>]
                    [--am <int>] [--ar <int>] [-t <int>] [-v <int>] [-h]

required arguments:
  -i, --in <file>             Input FASTA file or directory of files (gzipped or uncompressed)
  -o, --out <file>            Output filename

options:
  --filter <file>             Path to filter file (output of prefilter)
  --filter-threshold <float>  Align genome pairs above the threshold (0-1) [0]
  --outfmt <str>              Output format [standard]
                              choices: lite,standard,complete
  --out-aln <file>            Write alignments to the tsv <file>
  --out-ani <float>           Min. ANI to output (0-1) [0]
  --out-tani <float>          Min. tANI to output (0-1) [0]
  --out-gani <float>          Min. gANI to output (0-1) [0]
  --out-qcov <float>          Min. query coverage (aligned fraction) to output (0-1) [0]
  --out-rcov <float>          Min. reference coverage (aligned fraction) to output (0-1) [0]
  --mal <int>                 Min. anchor length [11]
  --msl <int>                 Min. seed length [7]
  --mrd <int>                 Max. dist. between approx. matches in reference [40]
  --mqd <int>                 Max. dist. between approx. matches in query [40]
  --reg <int>                 Min. considered region length [35]
  --aw <int>                  Approx. window length [15]
  --am <int>                  Max. no. of mismatches in approx. window [7]
  --ar <int>                  Min. length of run ending approx. extension [3]
  -t, --threads <int>         Number of threads [20]
  -v <int>                    Verbosity level [1]:
                              0: Errors only
                              1: Info
                              2: Debug
  -h, --help                  Show this help message and exit
```


## vclust_cluster

### Tool Description
Cluster genomes based on ANI metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
- **Homepage**: https://github.com/refresh-bio/vclust
- **Package**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vclust cluster -i <file> -o <file> --ids <file> [-r] [--algorithm <str>] [--metric <str>]
                      [--tani <float>] [--gani <float>] [--ani <float>] [--qcov <float>]
                      [--rcov <float>] [--len_ratio <float>] [--num_alns <int>]
                      [--leiden-resolution <float>] [--leiden-beta <float>]
                      [--leiden-iterations <int>] [-v <int>] [-h]

required arguments:
  -i, --in <file>              Input file with ANI metrics (tsv)
  -o, --out <file>             Output filename
  --ids <file>                 Input file with sequence identifiers (tsv)

options:
  -r, --out-repr               Output a representative genome for each cluster instead of numerical
                               cluster identifiers. The representative genome is selected as the one
                               with the longest sequence. [False]
  --algorithm <str>            Clustering algorithm [single]
                               * single: Single-linkage (connected component)
                               * complete: Complete-linkage
                               * uclust: UCLUST
                               * cd-hit: Greedy incremental
                               * set-cover: Greedy set-cover (MMseqs2)
                               * leiden: Leiden algorithm
  --metric <str>               Similarity metric for clustering [tani]
                               choices: tani,gani,ani
  --tani <float>               Min. total ANI (0-1) [0]
  --gani <float>               Min. global ANI (0-1) [0]
  --ani <float>                Min. ANI (0-1) [0]
  --qcov <float>               Min. query coverage/aligned fraction (0-1) [0]
  --rcov <float>               Min. reference coverage/aligned fraction (0-1) [0]
  --len_ratio <float>          Min. length ratio between shorter and longer sequence (0-1) [0]
  --num_alns <int>             Max. number of local alignments between two genomes; 0 means all
                               genome pairs are allowed. [0]
  --leiden-resolution <float>  Resolution parameter for the Leiden algorithm [0.7]
  --leiden-beta <float>        Beta parameter for the Leiden algorithm [0.01]
  --leiden-iterations <int>    Number of iterations for the Leiden algorithm [2]
  -v <int>                     Verbosity level [1]:
                               0: Errors only
                               1: Info
                               2: Debug
  -h, --help                   Show this help message and exit
```


## vclust_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
- **Homepage**: https://github.com/refresh-bio/vclust
- **Package**: https://anaconda.org/channels/bioconda/packages/vclust/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Vclust version 1.3.1 (Python 3.11.13)

Citation:
Zielezinski A, Gudys A et al. (2025) 
Ultrafast and accurate sequence alignment and clustering of viral genomes. 
Nat Methods. doi: https://doi.org/10.1038/s41592-025-02701-7

Installed at:
   /usr/local/lib/python3.11/site-packages/vclust.py (49.3 KB)
   /usr/local/lib/python3.11/site-packages/bin

Binary dependencies:
   Kmer-db              v2.3.1   (4.0 MB)
   LZ-ANI               v1.2.3   (3.4 MB)
   Clusty               v1.2.2   (3.8 MB)
   mfasta               v1.0.4   (2.8 MB)

[32;1mStatus: ready[0m
```

