# diamond CWL Generation Report

## diamond_makedb

### Tool Description
Build a DIAMOND database from a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Total Downloads**: 1.8M
- **Last updated**: 2026-02-15
- **GitHub**: https://github.com/bbuchfink/diamond
- **Stars**: N/A
### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--in                     input reference file in FASTA format/input DAA files for merge-daa
--taxonmap               protein accession to taxid mapping file
--taxonnodes             taxonomy nodes.dmp from NCBI
--taxonnames             taxonomy names.dmp from NCBI
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
```


## diamond_blastp

### Tool Description
DIAMOND is a sequence aligner for protein and translated DNA searches, designed for high performance analysis of big sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)
--query                  input query file
--strand                 query strands to search (both/minus/plus)
--un                     file for unaligned queries
--al                     file or aligned queries
--unfmt                  fo...
```


## diamond_blastx

### Tool Description
DIAMOND is a sequence aligner for protein and translated DNA searches. The blastx command aligns translated DNA queries against a protein reference database.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)
--query                  input query file
--strand                 query strands to search (both/minus/plus)
--un                     file for unaligned queries
--al                     file or aligned queries
--unfmt                  fo...
```


## diamond_cluster

### Tool Description
Clustering sequences using DIAMOND

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (defaul...
```


## diamond_linclust

### Tool Description
Linear-time clustering of protein sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (defaul...
```


## diamond_realign

### Tool Description
Realign sequences using the DIAMOND algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               p...
```


## diamond_recluster

### Tool Description
Recluster sequences using the DIAMOND algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--cluster-steps          Clustering steps
--kmer-ranking           Rank sequences based on kmer frequency in linear stage
--round-coverage         Per-round coverage cutoffs for cascaded clustering
--round-approx-id        Per-round approx-id cutoffs for cascaded clustering
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--clusters               Clustering input file mapping sequences to representatives
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append    ...
```


## diamond_reassign

### Tool Description
Reassign sequences to clusters or representatives using the DIAMOND protein aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--comp-based-stats       composition based statistics mode (0-4)
--masking                masking algorithm (none, seg, tantan=default)
--soft-masking           soft masking (none=default, seg, tantan)
--evalue                 maximum e-value to report alignments (default=0.001)
--motif-masking          softmask abundant motifs (0/1)
--approx-id              minimum approx. identity% to report an alignment/to cluster sequences
--ext                    Extension mode (banded-fast/banded-slow/full)
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--clusters               Clustering input file mapping sequences to representatives
--file-buffer-size       file buffer size in bytes (default=67108864)
--no-unlink              Do not unlink temporary files.
--ignore-warnings        Ignore warnings
--no-parse-seqids        Print raw seqids without parsing
--parallel-tmpdir        directory for temporary files used by multiprocessing
--bin                    number of query bins for seed search
--ext-chunk-size         chunk size for adaptive ranking (default=auto)
--no-ranking             disable ranking heuristic
--dbsize                 effective database size (in letters)
--no-auto-append         disable auto appending of DAA and DMND file e...
```


## diamond_view

### Tool Description
View and convert DIAMOND alignment archives (DAA)

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--max-target-seqs        maximum number of target sequences to report alignments for (default=25)
--top                    report alignments within this percentage range of top alignment score (overrides --max-target-seqs)
--outfmt                 output format
	0   = BLAST pairwise
	5   = BLAST XML
	6   = BLAST tabular
	100 = DIAMOND alignment archive (DAA)
	101 = SAM
	102 = Taxonomic classification
	103 = PAF
	104 = JSON (flat)

	Values 6 and 104 may be followed by a space-separated list of these keywords:

	             qseqid means Query Seq - id
	               qlen means Query sequence length
	             sseqid means Subject Seq - id
	          sallseqid means All subject Seq - id(s), separated by a ';'
	               slen means Subject sequence length
	             qstart means Start of alignment in query
	               qend means End of alignment in query
	             sstart means Start of alignment in subject
	               send means End of alignment in subject
	               qseq means Aligned part of query sequence
	               sseq means Aligned part of subject sequence
	             evalue means Expect value
	           bitscore means Bit score
	              score means Raw score
	             length means Alignment length
	             pident means Percentage of identical matches
	             nident means Number of identical matches
	           mismatch means Number of mismatches
	           positive means Number of positive - scoring matches
	            gapopen means Number of gap openings
	               gaps means Total number of gaps
	               ppos means Percenta...
```


## diamond_merge-daa

### Tool Description
Merge DAA files

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--out                    output file
--in                     input reference file in FASTA format/input DAA files for merge-daa
```


## diamond_getseq

### Tool Description
Display sequences from a DIAMOND database file by their sequence numbers.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--seq                    Space-separated list of sequence numbers to display.
```


## diamond_dbinfo

### Tool Description
Display information about a DIAMOND database file

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
```


## diamond_test

### Tool Description
The tool did not provide help text or a description. The output indicates an error when attempting to access help information.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: Invalid option: help

```


## diamond_makeidx

### Tool Description
Build an index for a DIAMOND database file.

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--faster                 enable faster mode
--fast                   enable fast mode
--mid-sensitive          enable mid-sensitive mode
--linclust-20            enable mode for linear search at 20% identity
--shapes-6x10            enable mode using 30 seed shapes of weight 10
--shapes-30x10           enable mode using 30 seed shapes of weight 10
--sensitive              enable sensitive mode)
--more-sensitive         enable more sensitive mode
--very-sensitive         enable very sensitive mode
--ultra-sensitive        enable ultra sensitive mode
--shapes                 number of seed shapes (default=all available)
```


## diamond_greedy-vertex-cover

### Tool Description
Greedy vertex cover clustering tool for DIAMOND

### Metadata
- **Docker Image**: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
- **Homepage**: https://github.com/bbuchfink/diamond
- **Package**: https://anaconda.org/channels/bioconda/packages/diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
--threads                number of CPU threads
--verbose                verbose console output
--log                    enable debug log
--quiet                  disable console output
--tmpdir                 directory for temporary files
--db                     database file
--out                    output file
--header                 Use header lines in tabular output format (0/simple/verbose).
--memory-limit           Memory limit in GB (default = 16G)
--member-cover           Minimum coverage% of the cluster member sequence (default=80.0)
--mutual-cover           Minimum mutual coverage% of the cluster member and representative sequence
--connected-component-depthDepth to cluster connected components
--no-reassign            Do not reassign to closest representative
--centroid-out           Output file for centroids
--edges                  Input file for greedy vertex cover
--edge-format            Edge format for greedy vertex cover (default/triplet)
--symmetric              Edges are symmetric
```


## Metadata
- **Skill**: generated
