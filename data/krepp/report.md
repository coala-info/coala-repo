# krepp CWL Generation Report

## krepp_index

### Tool Description
Build an index from k-mers of reference genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/bo1929/krepp
- **Stars**: N/A
### Original Help Text
```text
Build an index from k-mers of reference genomes.
Usage: krepp index [OPTIONS]

Options:
  --help                      
  -i,--input-file TEXT:FILE REQUIRED
                              TSV file <path> mapping reference IDs to (gzip compatible) paths/URLs.
  -o,--index-dir TEXT REQUIRED
                              Directory <path> in which the index will be stored.
  -t,--nwk-file TEXT:FILE     Path to the Newick file for the guide tree (must be rooted).
  -k,--kmer-len UINT:INT in [19 - 31]
                              Length of k-mers. [29]
  -w,--win-len UINT           Length of minimizer window (w>k). [k+6]
  -h,--num-positions UINT     Number of positions for the LSH. [k-16]
  -m,--modulo-lsh UINT:POSITIVE
                              Mudulo value to partition LSH space. [4]
  -r,--residue-lsh UINT:NONNEGATIVE
                              A k-mer x will be included only if r = LSH(x) mod m. [1]
  --frac,--no-frac{false}     Include k-mers with r <= LSH(x) mod m. [true]
  --sdust-t UINT:NONNEGATIVE  SDUST threshold (NCBI dustmasker: 20). [0]
  --sdust-w UINT:NONNEGATIVE  SDUST window (NCBI dustmasker: 64). [0]
```


## krepp_place

### Tool Description
Place queries on a tree with respect to an index.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

### Original Help Text
```text
Place queries on a tree with respect to an index.
Usage: krepp place [OPTIONS]

Options:
  --help                      
  -q,--query TEXT:(URL) OR (FILE) REQUIRED
                              Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
  -i,--index-dir TEXT:DIR REQUIRED
                              Directory <path> containing the reference index.
  -o,--output-path TEXT       Write output to a file at <path>. [stdout]
  --hdist-th UINT:NONNEGATIVE Maximum Hamming distance for a k-mer to match. [4]
  --chisq FLOAT:POSITIVE      Chi-square value for statistical distinguishability test, default correspons to alpha=90%. [2.706]
  --summarize,--no-summarize{false}
                              Summarize results into a table of read counts. If a read is mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi and --no-filter. [false]
  -t,--nwk-file TEXT:FILE Excludes: --lineage-file
                              Path to the Newick file for the (rooted) placement tree (overrides if the index has a backbone tree).
  -l,--lineage-file TEXT:FILE Excludes: --nwk-file
                              Path to the Greengenes/GTDB style taxonomic lineage file, the first column has to match reference IDs present in the index (tolerates missing IDs).
  --tau UINT:NONNEGATIVE      Highest Hamming distance for placement threshold (increase to relax). [2]
  --multi,--no-multi{false}   Output all candidate placements satisfying the filters (not just the largest clade). [true]
  --filter,--no-filter{false} Filter a placement when there is not enough k-mer matches below threshold tau. [true]
  --tabular,--no-tabular{false}
                              Output the per query sequence placements (taxonomic/phylogenetic) in a tab-separated format. [false]
```


## krepp_dist

### Tool Description
Estimate distances of queries to genomes in an index.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

### Original Help Text
```text
Estimate distances of queries to genomes in an index.
Usage: krepp dist [OPTIONS]

Options:
  --help                      
  -q,--query TEXT:(URL) OR (FILE) REQUIRED
                              Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
  -i,--index-dir TEXT:DIR REQUIRED
                              Directory <path> containing the reference index.
  -o,--output-path TEXT       Write output to a file at <path>. [stdout]
  --hdist-th UINT:NONNEGATIVE Maximum Hamming distance for a k-mer to match. [4]
  --chisq FLOAT:POSITIVE      Chi-square value for statistical distinguishability test, default correspons to alpha=90%. [2.706]
  --summarize,--no-summarize{false}
                              Summarize results into a table of read counts. If a read is mapped/placed to n references/edges, each gets 1/n. Overrides --no-multi and --no-filter. [false]
  --dist-max FLOAT:FLOAT in [1e-08 - 0.33]
                              Maximum distance to report for matching references, overrides --filter if given. [0.25]
  --multi,--no-multi{false}   Output all distances satisfying the filters (not just the closest reference). [true]
  --filter,--no-filter{false} Filter a hit if its distance is too high compared to the best hit (based on the statistical significance). [false]
```


## krepp_inspect

### Tool Description
Display statistics and information for a given index.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

### Original Help Text
```text
Display statistics and information for a given index.
Usage: krepp inspect [OPTIONS]

Options:
  --help                      
  -i,--index-dir TEXT:DIR REQUIRED
                              Directory <path> containing reference index.
```


## krepp_sketch

### Tool Description
Create a sketch from k-mers in a single FASTA/FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

### Original Help Text
```text
Create a sketch from k-mers in a single FASTA/FASTQ file.
Usage: krepp sketch [OPTIONS]

Options:
  --help                      
  -i,--input-file TEXT:(URL) OR (FILE) REQUIRED
                              Input FASTA/FASTQ file <path> (or URL) (gzip compatible).
  -o,--output-path TEXT REQUIRED
                              Path to store the resulting binary sketch file.
  -k,--kmer-len UINT:INT in [19 - 31]
                              Length of k-mers. [26]
  -w,--win-len UINT           Length of minimizer window (w>=k). [k+6]
  -h,--num-positions UINT     Number of positions for the LSH. [k-16]
  -m,--modulo-lsh UINT:POSITIVE
                              Modulo value to partition LSH space. [4]
  -r,--residue-lsh UINT:NONNEGATIVE
                              A k-mer x will be included only if r = LSH(x) mod m. [1]
  --frac,--no-frac{false}     Include k-mers with r <= LSH(x) mod m. [true]
  --sdust-t UINT:NONNEGATIVE  SDUST threshold (NCBI dustmasker: 20). [0]
  --sdust-w UINT:NONNEGATIVE  SDUST window (NCBI dustmasker: 64). [0]
```


## krepp_seek

### Tool Description
Seek query sequences in a sketch and estimate distances.

### Metadata
- **Docker Image**: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
- **Homepage**: https://github.com/bo1929/krepp
- **Package**: https://anaconda.org/channels/bioconda/packages/krepp/overview
- **Validation**: PASS

### Original Help Text
```text
Seek query sequences in a sketch and estimate distances.
Usage: krepp seek [OPTIONS]

Options:
  --help                      
  -q,--query TEXT:(URL) OR (FILE) REQUIRED
                              Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
  -i,--sketch-path TEXT:FILE REQUIRED
                              Sketch file at <path> to query.
  -o,--output-path TEXT       Write output to a file at <path>. [stdout]
  --hdist-th UINT:NONNEGATIVE Maximum Hamming distance for a k-mer to match. [4]
```

