# fba CWL Generation Report

## fba_extract

### Tool Description
Extract cell and feature barcodes from paired fastq files. For single cell assays, read 1 usually contains cell partitioning and UMI information, and read 2 contains feature information.

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jlduan/fba
- **Stars**: N/A
### Original Help Text
```text
usage: fba extract [-h] -1 READ1 -2 READ2 -w WHITELIST -f FEATURE_REF -o
                   OUTPUT [-r1_c READ1_COORDINATE] -r2_c READ2_COORDINATE
                   [-cb_m CELL_BARCODE_MISMATCHES]
                   [-fb_m FEATURE_BARCODE_MISMATCHES]
                   [-cb_n CB_NUM_N_THRESHOLD] [-fb_n FB_NUM_N_THRESHOLD]
                   [-cb_rc]

Extract cell and feature barcodes from paired fastq files. For single cell
assays, read 1 usually contains cell partitioning and UMI information, and
read 2 contains feature information.

optional arguments:
  -h, --help            show this help message and exit
  -1 READ1, --read1 READ1
                        specify fastq file for read 1
  -2 READ2, --read2 READ2
                        specify fastq file for read 2
  -w WHITELIST, --whitelist WHITELIST
                        specify a whitelist of accepted cell barcodes
  -f FEATURE_REF, --feature_ref FEATURE_REF
                        specify a reference of feature barcodes
  -o OUTPUT, --output OUTPUT
                        specify an output file
  -r1_c READ1_COORDINATE, --read1_coordinate READ1_COORDINATE
                        specify coordinate 'start,end' of read 1 to search.
                        For example, '0,16': starts at 0, stops at 15.
                        Nucleotide bases outside the range will be masked as
                        lowercase in the output. Default (0,16)
  -r2_c READ2_COORDINATE, --read2_coordinate READ2_COORDINATE
                        see '-r1_c/--read1_coordinate'
  -cb_m CELL_BARCODE_MISMATCHES, --cb_mismatches CELL_BARCODE_MISMATCHES
                        specify cell barcode mismatching threshold. Default
                        (1)
  -fb_m FEATURE_BARCODE_MISMATCHES, --fb_mismatches FEATURE_BARCODE_MISMATCHES
                        specify feature barcode mismatching threshold. Default
                        (1)
  -cb_n CB_NUM_N_THRESHOLD, --cb_num_n_threshold CB_NUM_N_THRESHOLD
                        specify maximum number of ambiguous nucleotides
                        allowed for read 1. Default (3)
  -fb_n FB_NUM_N_THRESHOLD, --fb_num_n_threshold FB_NUM_N_THRESHOLD
                        specify maximum number of ambiguous nucleotides
                        allowed for read 2. Default (3)
  -cb_rc, --cell_barcode_reverse_complement
                        specify to convert cell barcode sequences into their
                        reverse-complement counterparts for processing.
```


## fba_map

### Tool Description
Quantify enriched transcripts (through hybridization or PCR amplification) from parent single cell libraries. Read 1 contains cell partitioning and UMI information, and read 2 contains transcribed regions of enriched/targeted transcripts of interest. BWA (Li, H. 2013) or Bowtie2 (Langmead, B., et al. 2012) is used for read 2 alignment. The quantification (UMI deduplication) of enriched/targeted transcripts is powered by UMI-tools (Smith, T., et al. 2017).

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba map [-h] -1 READ1 -2 READ2 -w WHITELIST -f FEATURE_REF -o OUTPUT
               [-r1_c READ1_COORDINATE] [-cb_m CELL_BARCODE_MISMATCHES]
               [-cb_n CB_NUM_N_THRESHOLD] [-al {bwa,bowtie2}] [--mapq MAPQ]
               [-us UMI_POS_START] [-ul UMI_LENGTH] [-um UMI_MISMATCHES]
               [-ud {unique,percentile,cluster,adjacency,directional}]
               [--output_directory OUTPUT_DIRECTORY] [-t THREADS]
               [--num_n_ref NUM_N_REF]

Quantify enriched transcripts (through hybridization or PCR amplification)
from parent single cell libraries. Read 1 contains cell partitioning and UMI
information, and read 2 contains transcribed regions of enriched/targeted
transcripts of interest. BWA (Li, H. 2013) or Bowtie2 (Langmead, B., et al.
2012) is used for read 2 alignment. The quantification (UMI deduplication) of
enriched/targeted transcripts is powered by UMI-tools (Smith, T., et al.
2017).

optional arguments:
  -h, --help            show this help message and exit
  -1 READ1, --read1 READ1
                        specify fastq file for read 1
  -2 READ2, --read2 READ2
                        specify fastq file for read 2
  -w WHITELIST, --whitelist WHITELIST
                        specify a whitelist of accepted cell barcodes
  -f FEATURE_REF, --feature_ref FEATURE_REF
                        specify a reference of feature barcodes
  -o OUTPUT, --output OUTPUT
                        specify an output file
  -r1_c READ1_COORDINATE, --read1_coordinate READ1_COORDINATE
                        specify coordinate 'start,end' of read 1 to search.
                        For example, '0,16': starts at 0, stops at 15.
                        Nucleotide bases outside the range will be masked as
                        lowercase in the output. Default (0,16)
  -cb_m CELL_BARCODE_MISMATCHES, --cb_mismatches CELL_BARCODE_MISMATCHES
                        specify cell barcode mismatching threshold. Default
                        (1)
  -cb_n CB_NUM_N_THRESHOLD, --cb_num_n_threshold CB_NUM_N_THRESHOLD
                        specify maximum number of ambiguous nucleotides
                        allowed for read 1. Default (3)
  -al {bwa,bowtie2}, --aligner {bwa,bowtie2}
                        specify aligner for read 2. Default (bwa)
  --mapq MAPQ, --mapping_quality MAPQ
                        specify minimal mapping quality required for feature
                        mapping. Default (10)
  -us UMI_POS_START, --umi_start UMI_POS_START
                        specify expected UMI starting postion on read 1.
                        Default (16)
  -ul UMI_LENGTH, --umi_length UMI_LENGTH
                        specify the length of UMIs on read 1. Reads with UMI
                        length less than this value will be discarded. Default
                        (12)
  -um UMI_MISMATCHES, --umi_mismatches UMI_MISMATCHES
                        specify the maximun edit distance allowed for UMIs on
                        read 1 for deduplication. Default (1)
  -ud {unique,percentile,cluster,adjacency,directional}, --umi_deduplication_method {unique,percentile,cluster,adjacency,directional}
                        specify UMI deduplication method (powered by UMI-
                        tools. Smith, T., et al. 2017). Default (directional)
  --output_directory OUTPUT_DIRECTORY
                        specify a temp directory. Default (./barcode_mapping)
  -t THREADS, --threads THREADS
                        specify number of threads to launch. The default is to
                        use all available
  --num_n_ref NUM_N_REF
                        specify the number of Ns to separate sequences
                        belonging to the same feature. Default (0)
```


## fba_filter

### Tool Description
Filter extracted cell and feature barcodes (output of `extract` or `qc`). Additional fragment filter/selection can be applied through `-cb_seq` and/or `-fb_seq`.

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba filter [-h] -i INPUT -o OUTPUT [-cb_s CELL_BARCODE_POS_START]
                  [-cb_m CELL_BARCODE_MISMATCHES]
                  [-cb_ls CELL_BARCODE_LEFT_SHIFT]
                  [-cb_rs CELL_BARCODE_RIGHT_SHIFT]
                  [-cb_seq CELL_BARCODE_EXTRA_SEQ]
                  [-cb_seq_m CELL_BARCODE_EXTRA_SEQ_MISMATCHES]
                  [-fb_s FEATURE_BARCODE_POS_START]
                  [-fb_m FEATURE_BARCODE_MISMATCHES]
                  [-fb_ls FEATURE_BARCODE_LEFT_SHIFT]
                  [-fb_rs FEATURE_BARCODE_RIGHT_SHIFT]
                  [-fb_seq FEATURE_BARCODE_EXTRA_SEQ]
                  [-fb_seq_m FEATURE_BARCODE_EXTRA_SEQ_MISMATCHES]

Filter extracted cell and feature barcodes (output of `extract` or `qc`).
Additional fragment filter/selection can be applied through `-cb_seq` and/or
`-fb_seq`.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify an input file. The output of `extract` or `qc`
  -o OUTPUT, --output OUTPUT
                        specify an output file
  -cb_s CELL_BARCODE_POS_START, --cb_start CELL_BARCODE_POS_START
                        specify expected cell barcode starting postion on read
                        1. Default (0)
  -cb_m CELL_BARCODE_MISMATCHES, --cb_mismatches CELL_BARCODE_MISMATCHES
                        specify cell barcode mismatching threshold. Default
                        (1)
  -cb_ls CELL_BARCODE_LEFT_SHIFT, --cb_left_shift CELL_BARCODE_LEFT_SHIFT
                        specify the maximum left shift allowed for cell
                        barcode. Default (1)
  -cb_rs CELL_BARCODE_RIGHT_SHIFT, --cb_right_shift CELL_BARCODE_RIGHT_SHIFT
                        specify the maximum right shift allowed for cell
                        barcode. Default (1)
  -cb_seq CELL_BARCODE_EXTRA_SEQ, --cb_extra_seq CELL_BARCODE_EXTRA_SEQ
                        specify an extra constant sequence to filter on read
                        1. Default (None)
  -cb_seq_m CELL_BARCODE_EXTRA_SEQ_MISMATCHES, --cb_extra_seq_mismatches CELL_BARCODE_EXTRA_SEQ_MISMATCHES
                        specify the maximun edit distance allowed for the
                        extra constant sequence on read 1 for filtering.
                        Default (None)
  -fb_s FEATURE_BARCODE_POS_START, --fb_start FEATURE_BARCODE_POS_START
                        specify expected feature barcode starting postion on
                        read 2. Default (10)
  -fb_m FEATURE_BARCODE_MISMATCHES, --fb_mismatches FEATURE_BARCODE_MISMATCHES
                        specify feature barcode mismatching threshold. Default
                        (1)
  -fb_ls FEATURE_BARCODE_LEFT_SHIFT, --fb_left_shift FEATURE_BARCODE_LEFT_SHIFT
                        specify the maximum left shift allowed for feature
                        barcode. Default (1)
  -fb_rs FEATURE_BARCODE_RIGHT_SHIFT, --fb_right_shift FEATURE_BARCODE_RIGHT_SHIFT
                        specify the maximum right shift allowed for feature
                        barcode. Default (1)
  -fb_seq FEATURE_BARCODE_EXTRA_SEQ, --fb_extra_seq FEATURE_BARCODE_EXTRA_SEQ
                        specify an extra constant sequence to filter on read
                        2. Default (None)
  -fb_seq_m FEATURE_BARCODE_EXTRA_SEQ_MISMATCHES, --fb_extra_seq_mismatches FEATURE_BARCODE_EXTRA_SEQ_MISMATCHES
                        specify the maximun edit distance allowed for the
                        extra constant sequence on read 2. Default (None)
```


## fba_count

### Tool Description
Count UMIs per feature per cell (UMI deduplication), powered by UMI-tools (Smith, T., et al. 2017). Take the output of `extract` or `filter` as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba count [-h] -i INPUT -o OUTPUT [-us UMI_POS_START] [-ul UMI_LENGTH]
                 [-um UMI_MISMATCHES]
                 [-ud {unique,percentile,cluster,adjacency,directional}]
                 [-cb_rc]

Count UMIs per feature per cell (UMI deduplication), powered by UMI-tools
(Smith, T., et al. 2017). Take the output of `extract` or `filter` as input.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify input files. Multiple '-i' flags can be used.
  -o OUTPUT, --output OUTPUT
                        specify an output file
  -us UMI_POS_START, --umi_start UMI_POS_START
                        specify expected UMI starting postion on read 1.
                        Coordinate is 0-based, half-open. Default (16)
  -ul UMI_LENGTH, --umi_length UMI_LENGTH
                        specify the length of UMIs on read 1. Reads with UMI
                        length shorter than this value will be discarded.
                        Coordinate is 0-based, half-open. For example, '-us 16
                        -ul 12' means UMI starts at 16 ends at 27. Default
                        (12)
  -um UMI_MISMATCHES, --umi_mismatches UMI_MISMATCHES
                        specify the maximun edit distance allowed for UMIs on
                        read 1 for deduplication. Default (1)
  -ud {unique,percentile,cluster,adjacency,directional}, --umi_deduplication_method {unique,percentile,cluster,adjacency,directional}
                        specify UMI deduplication method (powered by UMI-
                        tools. Smith, T., et al. 2017). Default (directional)
  -cb_rc, --cell_barcode_reverse_complement
                        specify to convert cell barcode sequences into their
                        reverse-complement counterparts in the output.
```


## fba_demultiplex

### Tool Description
Demultiplex cells based on the abundance of features (matrix generated by `count` as input).

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba demultiplex [-h] -i INPUT [--output_directory OUTPUT_DIRECTORY]
                       [-dm {1}] [-nm {clr,log}] [-q QUANTILE]
                       [-cm {kmedoids,hdbscan}] [-v] [-vm {tsne,umap}]
                       [-nc NUM_CELLS]

Demultiplex cells based on the abundance of features (matrix generated by
`count` as input).

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        specify an input file (feature count matrix). The
                        output of `count`
  --output_directory OUTPUT_DIRECTORY
                        specify a output directory. Default (./demultiplexed)
  -dm {1}               specify demultiplexing method. '1': Stoeckius et al.
                        2018. Default (1)
  -nm {clr,log}         specify normalization method. 'clr': centred log-ratio
                        transformation. 'log': log10 transformation. Default
                        (clr)
  -q QUANTILE, --quantile QUANTILE
                        specify quantile cutoff for the probability mass
                        function for demultiplexing method 1. Default (0.9999)
  -cm {kmedoids,hdbscan}, --clustering_method {kmedoids,hdbscan}
                        specify initial clustering method for demultiplexing
                        method 1. Default (kmedoids)
  -v, --visualization   specify to visualize demultiplexing result
  -vm {tsne,umap}, --visualization_method {tsne,umap}
                        specify embedding method for visualization (works if
                        '-v' is given). Default (tsne)
  -nc NUM_CELLS, --num_cells NUM_CELLS
                        specify minimal number of positive cells required for
                        a feature to be included for demultiplexing. Default
                        (200)
```


## fba_qc

### Tool Description
Generate diagnostic information. If `-1` is omitted, bulk mode is enabled and only read 2 will be analyzed.

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba qc [-h] [-1 READ1] -2 READ2 [-w WHITELIST] -f FEATURE_REF
              [-r1_c READ1_COORDINATE] [-r2_c READ2_COORDINATE]
              [-cb_m CELL_BARCODE_MISMATCHES]
              [-fb_m FEATURE_BARCODE_MISMATCHES] [-cb_n CB_NUM_N_THRESHOLD]
              [-fb_n FB_NUM_N_THRESHOLD] [-cb_rc] [-t THREADS] [-n NUM_READS]
              [--chunk_size CHUNK_SIZE] [--output_directory OUTPUT_DIRECTORY]

Generate diagnostic information. If `-1` is omitted, bulk mode is enabled and
only read 2 will be analyzed.

optional arguments:
  -h, --help            show this help message and exit
  -1 READ1, --read1 READ1
                        specify fastq file for read 1
  -2 READ2, --read2 READ2
                        specify fastq file for read 2. If only read 2 file is
                        provided, bulk mode is enabled (skipping arguments
                        '-w/--whitelist', '-cb_m/--cb_mismatches',
                        '-r1_c/--read1_coordinate', must provide
                        '-r2_c/--read2_coordinate' and
                        '-fb_m/--fb_mismatches'). In bulk mode, read 2 will be
                        searched against reference feature barcodes and read
                        count for each feature barcode will be summarized
  -w WHITELIST, --whitelist WHITELIST
                        specify a whitelist of accepted cell barcodes
  -f FEATURE_REF, --feature_ref FEATURE_REF
                        specify a reference of feature barcodes
  -r1_c READ1_COORDINATE, --read1_coordinate READ1_COORDINATE
                        specify coordinate 'start,end' of read 1 to search
                        (doesn't need to be the exact expected barcode
                        coordinate). Coordinate is 0-based, half-open. For
                        example, '0,16': starts at 0, stops at 15. The default
                        is to use all the nucleotide bases. Nucleotide bases
                        outside the range will be masked as lowercase in the
                        output
  -r2_c READ2_COORDINATE, --read2_coordinate READ2_COORDINATE
                        see '-r1_c/--read1_coordinate'
  -cb_m CELL_BARCODE_MISMATCHES, --cb_mismatches CELL_BARCODE_MISMATCHES
                        specify cell barcode mismatching threshold. Default
                        (3)
  -fb_m FEATURE_BARCODE_MISMATCHES, --fb_mismatches FEATURE_BARCODE_MISMATCHES
                        specify feature barcode mismatching threshold. Default
                        (3)
  -cb_n CB_NUM_N_THRESHOLD, --cb_num_n_threshold CB_NUM_N_THRESHOLD
                        specify maximum number of ambiguous nucleotides
                        allowed for read 1. The default is no limit
  -fb_n FB_NUM_N_THRESHOLD, --fb_num_n_threshold FB_NUM_N_THRESHOLD
                        specify maximum number of ambiguous nucleotides
                        allowed for read 2. The default is no limit
  -cb_rc, --cell_barcode_reverse_complement
                        specify to convert cell barcode sequences into their
                        reverse-complement counterparts for processing.
  -t THREADS, --threads THREADS
                        specify number of threads for barcode extraction.
                        Default is to use all available
  -n NUM_READS, --num_reads NUM_READS
                        specify number of reads for analysis. Set to (None)
                        will analyze all the reads. Default (100,000)
  --chunk_size CHUNK_SIZE
                        specify the chunk size for multiprocessing. Default
                        (50,000)
  --output_directory OUTPUT_DIRECTORY
                        specify a output directory. Default (./qc)
```


## fba_kallisto_wrapper

### Tool Description
Deploy kallisto/bustools for feature barcoding quantification (just a wrapper) (Bray, N.L., et al. 2016).

### Metadata
- **Docker Image**: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/jlduan/fba
- **Package**: https://anaconda.org/channels/bioconda/packages/fba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fba kallisto_wrapper [-h] -1 READ1 -2 READ2 -w WHITELIST -f FEATURE_REF
                            [--technology TECHNOLOGY] -o OUTPUT [-t THREADS]
                            [--output_directory OUTPUT_DIRECTORY]

Deploy kallisto/bustools for feature barcoding quantification (just a wrapper)
(Bray, N.L., et al. 2016).

optional arguments:
  -h, --help            show this help message and exit
  -1 READ1, --read1 READ1
                        specify fastq file for read 1
  -2 READ2, --read2 READ2
                        specify fastq file for read 2
  -w WHITELIST, --whitelist WHITELIST
                        specify a whitelist of accepted cell barcodes
  -f FEATURE_REF, --feature_ref FEATURE_REF
                        specify a reference of feature barcodes
  --technology TECHNOLOGY
                        specify feature barcoding technology. The default is
                        10xv3
  -o OUTPUT, --output OUTPUT
                        specify an output file
  -t THREADS, --threads THREADS
                        specify number of kallisto/bustools threads to launch.
                        Default (1)
  --output_directory OUTPUT_DIRECTORY
                        specify a temp directory. Default (./kallisto)
```

