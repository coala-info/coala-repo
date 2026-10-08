# downpore CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| downpore_align | PASS |  |
| downpore_consensus | PASS |  |
| downpore_correct | Failed | tool bug: the experimental command panics (index out of range) on 2 of 3 real nanopore read sets, and successful runs print only progress counts, no corrected reads. |
| downpore_kmers | PASS |  |
| downpore_map | PASS |  |
| downpore_overlap | PASS | With -k 12 -num_seeds 30 all 411 overlaps on 1000 real nanopore reads agree with minimap2 read positions; with the default seeds the tool panics (index out of range). |
| downpore_subseq | PASS |  |
| downpore_trim | PASS |  |

## downpore_consensus

### Tool Description
Builds a consensus sequence from a set of reads of the same region with dynamic time warping; writes it to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
$ downpore help consensus
-matrix    -ma  K-mer confusion matrix to use in place of a model                         (default:)   
-k         -k   K-mer size for alignment when no model specified                          (default:5)  
-input     -i   Fasta/fastq input file                                                    (default:)   
-rc_input  -r   Additional input file containing sequences from reverse-complement reads  (default:)   
-model     -mo  Model file containing current levels                                      (default:)
```

## downpore_align

### Tool Description
Aligns a set of reads to each other (or to an optional reference) with dynamic time warping; writes the alignment to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
$ downpore help align
-input      -i   Fasta/fastq input file                                                    (default:)   
-rc_input   -rc  Additional input file containing sequences from reverse-complement reads  (default:)   
-model      -m   Model file containing current levels                                      (default:)   
-k          -k   K-mer size for alignment when no model specified                          (default:5)  
-reference  -re  (optional) A fasta file containing a reference sequence to align against  (default:)
```

## downpore_kmers

### Tool Description
Measures per-k-mer read accuracy from reads aligned to a reference (SAM) and writes heatmap files.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
$ downpore help kmers
-input               -i  Reads input file                 (default:)     
-training_alignment      SAM training file                (default:)     
-map_size            -m  Dimensions for heatmaps          (default:100)  
-num_workers         -n  Number of worker threads to use  (default:4)    
-alignment           -a  SAM input file                   (default:)     
-reference           -r  Reference fasta file             (default:)     
-training                Training input file              (default:)     
-training_ref            Training reference fasta file    (default:)     
-k                   -k  K-mer size                       (default:10)
```

## downpore_overlap

### Tool Description
Find overlaps amongst a set of long reads; writes PAF to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
-chunk_size        -c  Size to chop long reads into for querying against, in bases     (default:10000)  
-query_batch_size  -q  Maximum number of queries per batch (if max seeds not reached)  (default:20000)  
-num_workers           Number of worker threads to spawn                               (default:4)      
-himem             -h  Whether to cache all reads in memory                            (default:true)   
-overlap_size      -o  Size of overlap to search for in bases                          (default:1000)   
-num_seeds             Minimum number of seeds to generate for each overlap query      (default:15)     
-min_hits          -m  Minimum proportion of seeds that must match each query          (default:0.25)   
-input             -i  Fasta/fastq input file                                          (default:)       
-seed_values           File containing values to use during seed selection.            (default:)       
-k                 -k  Number of bases in each seed                                    (default:10)     
-seed_batch_size       Maximum total unique seeds to use in each query batch           (default:10000)  
```

## downpore_map

### Tool Description
Map long reads approximately to a single reference sequence; writes PAF to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
-circular     -ci  Whether the reference genome is circular                       (default:true)   
-k            -k   Length of seeds in bases                                       (default:11)     
-chunk_size   -ch  The number of bases for reference index chunks                 (default:10000)  
-seed_rate    -s   The maximum number of bases between seeds in the reference     (default:40)     
-input        -i   Fasta/fastq input file                                         (default:)       
-reference    -r   A fasta file containing a reference sequence to align against  (default:)       
-query_size   -q   The number of bases to query at a time                         (default:1000)   
-min_length   -m   The minimum sequence size to generate queries from             (default:500)    
-num_workers  -n   The number of worker process to use for mapping                (default:4)      
```

## downpore_trim

### Tool Description
Remove adapters or barcodes from long reads, optionally demultiplexing by barcode.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
-chunk_size          -chu  Split long reads into chunks of this size when indexing                (default:5000)   
-discard_middle      -dis  Whether to keep halves of split reads                                  (default:false)  
-verbosity           -v    Level (0-2) of output to stderr                                        (default:1)      
-front_adapters      -f    Fasta/fastq file containing front adapters                             (default:)       
-himem               -h    Whether to cache all reads in memory                                   (default:false)  
-require_pairs       -r    Whether front/back adapters with the same name must appear together    (default:false)  
-extra_middle_trim         Number of bases to remove around read-splitting adapters               (default:100)    
-determine_adapters  -det  Whether to use a fixed set of adapters or to search for those present  (default:true)   
-middle_threshold    -m    % identity for matching adapters that split reads                      (default:85)     
-check_reads         -che  Number of reads to use to determine which adapters are present         (default:10000)  
-adapter_threshold   -a    % identity required at check_adapters stage                            (default:90)     
-extra_end_trim            Number of bases to remove around adapters at read edges                (default:5)      
-back_adapters       -b    Fasta/fastq file containing back adapters                              (default:)       
-num_workers         -n    Number of threads to use                                               (default:4)      
-demultiplex         -dem  A path to demultiplex to, otherwise write sequences to stdout          (default:)       
-input               -i    Fasta/fastq/gzip input file                                            (default:)       
-k                   -k    k-mer size to use when matching adapters                               (default:6)      
-tag_adapters        -t    Whether to add adapter names to output sequence names                  (default:true)   
```

## downpore_subseq

### Tool Description
Return subsequences of a fasta file for start/end/strand requests read from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
-input        -i  Fasta/fastq input file            (default:)       
-num_workers  -n  Number of worker threads to use   (default:4)      
-himem        -h  Whether to cache reads in memory  (default:false)  
```

## downpore_correct

### Tool Description
Experimental long-read correction by overlap consensus.

### Metadata
- **Docker Image**: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
- **Homepage**: https://github.com/jteutenberg/downpore
- **Package**: https://anaconda.org/channels/bioconda/packages/downpore/overview
- **Validation**: PASS

### Original Help Text
```text
-seed_batch_size  -s   Maximum total unique seeds to use in each query batch        (default:10000)  
-k                -k   Number of bases in each seed                                 (default:10)     
-num_workers           Number of worker threads to spawn                            (default:4)      
-input            -i   Fasta/fastq input file                                       (default:)       
-trim             -t   Whether to search for and trim adapters: 0=off, 1=on         (default:0)      
-front_adapters   -f   Fasta/fastq file containing front adapters                   (default:)       
-himem            -h   Whether to cache all reads in memory                         (default:true)   
-overlap_size     -o   Size of overlap to search for in bases                       (default:1000)   
-num_seeds             Minimum number of seeds to generate for each overlap query   (default:15)     
-chunk_size       -c   Size to chop long reads into for querying against, in bases  (default:10000)  
-min_hits         -mi  Minimum proportion of seeds that must match each query       (default:0.25)   
-back_adapters    -b   Fasta/fastq file containing back adapters                    (default:)       
-model            -mo  K-mer numeric values to use in alignment                     (default:)       
```

## Metadata
- **Skill**: generated
