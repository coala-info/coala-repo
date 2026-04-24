cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats-rf_CATS_rf
label: cats-rf_CATS_rf
doc: "reference-free transcriptome assembly assessment\n\nTool homepage: https://github.com/bodulic/CATS-rf"
inputs:
  - id: transcriptome
    type: File
    doc: Transcriptome file
    inputBinding:
      position: 1
  - id: reads1
    type: File
    doc: First FASTQ file
    inputBinding:
      position: 2
  - id: reads2
    type:
      - 'null'
      - File
    doc: Second FASTQ file (for paired-end reads)
    inputBinding:
      position: 3
  - id: accuracy_breakpoints
    type:
      - 'null'
      - string
    doc: Per-base accuracy distribution breakpoints (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -I
  - id: alpha_compression_factor
    type:
      - 'null'
      - float
    doc: Alpha compression factor for sigmoid transformation applied to bridge 
      index during integrity score component calculation
    inputBinding:
      position: 104
      prefix: -a
  - id: beta_compression_factor
    type:
      - 'null'
      - float
    doc: Beta compression factor for sigmoid transformation applied to bridge 
      index during integrity score component calculation
    inputBinding:
      position: 104
      prefix: -b
  - id: coverage_breakpoints
    type:
      - 'null'
      - string
    doc: Per-base coverage distribution breakpoints (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -i
  - id: coverage_weight
    type:
      - 'null'
      - float
    doc: Base coverage weight
    inputBinding:
      position: 104
      prefix: -w
  - id: distance_outlier_correction_factor
    type:
      - 'null'
      - float
    doc: Correction factor for distance outlier threshold calculation
    inputBinding:
      position: 104
      prefix: -c
  - id: gnu_parallel_memory_block_size
    type:
      - 'null'
      - string
    doc: Memory block size for GNU Parallel
    inputBinding:
      position: 104
      prefix: -M
  - id: gnu_sort_ram_percentage
    type:
      - 'null'
      - int
    doc: Percentage of available RAM used by GNU sort
    inputBinding:
      position: 104
      prefix: -G
  - id: higher_distance_outlier_factor
    type:
      - 'null'
      - float
    doc: Multiplicative factor for higher distance outlier threshold calculation
    inputBinding:
      position: 104
      prefix: -X
  - id: improperly_paired_reads_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of improperly paired reads within a 
      transcript distribution breakpoints (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -y
  - id: lar_bases_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of LAR bases distribution breakpoints 
      (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -U
  - id: lar_extension_penalty
    type:
      - 'null'
      - float
    doc: LAR extension penalty
    inputBinding:
      position: 104
      prefix: -E
  - id: lar_threshold
    type:
      - 'null'
      - float
    doc: Local accuracy threshold for LAR characterization
    inputBinding:
      position: 104
      prefix: -Z
  - id: lcr_bases_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of LCR bases distribution breakpoints 
      (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -u
  - id: lcr_extension_penalty
    type:
      - 'null'
      - float
    doc: LCR extension penalty
    inputBinding:
      position: 104
      prefix: -e
  - id: lcr_threshold
    type:
      - 'null'
      - float
    doc: Local coverage threshold for LCR characterization
    inputBinding:
      position: 104
      prefix: -z
  - id: library_strandness
    type:
      - 'null'
      - string
    doc: Library strandness, fr = forward-reverse, rf = reverse-forward, u = 
      unstranded, a = automatic detection
    inputBinding:
      position: 104
      prefix: -S
  - id: library_type
    type:
      - 'null'
      - string
    doc: 'Paired- vs. single-end library configuration: pe = paired-end, se = single-end'
    inputBinding:
      position: 104
      prefix: -C
  - id: lower_distance_outlier_factor
    type:
      - 'null'
      - float
    doc: Multiplicative factor for lower distance outlier threshold calculation
    inputBinding:
      position: 104
      prefix: -x
  - id: max_distance_unmapped_pair
    type:
      - 'null'
      - int
    doc: Maximum distance from transcript ends for reads with unmapped pair to 
      be considered evidence of transcript end incompleteness or fragmentation 
      (in bp)
    inputBinding:
      position: 104
      prefix: -d
  - id: max_distinct_mappings
    type:
      - 'null'
      - int
    doc: Maximum number of distinct mappings per read
    inputBinding:
      position: 104
      prefix: -N
  - id: mean_fragment_length
    type:
      - 'null'
      - float
    doc: Estimated mean of fragment length needed for transcript quantification 
      (single-end mode only)
    inputBinding:
      position: 104
      prefix: -m
  - id: mean_transcript_coverage_breakpoints
    type:
      - 'null'
      - string
    doc: Mean transcript coverage distribution breakpoints (specified with 
      x,y,z...)
    inputBinding:
      position: 104
      prefix: -r
  - id: min_accurate_base_threshold
    type:
      - 'null'
      - float
    doc: Minimum accuracy for a base to be considered accurate
    inputBinding:
      position: 104
      prefix: -A
  - id: min_bridging_events_fragmented
    type:
      - 'null'
      - int
    doc: Minimum number of bridging events for transcripts to be considered 
      fragmented
    inputBinding:
      position: 104
      prefix: -f
  - id: num_splits_tables
    type:
      - 'null'
      - int
    doc: Number of splits performed on positional and read pair mapping tables
    inputBinding:
      position: 104
      prefix: -T
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: CATS-rf output directory name
    inputBinding:
      position: 104
      prefix: -D
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: CATS-rf output file prefix
    inputBinding:
      position: 104
      prefix: -o
  - id: overwrite_output_directory
    type:
      - 'null'
      - boolean
    doc: Overwrite the CATS-rf output directory
    inputBinding:
      position: 104
      prefix: -O
  - id: phred_quality_encoding
    type:
      - 'null'
      - string
    doc: Phred quality encoding of FASTQ files, 33 = phred33, 64 = phred64
    inputBinding:
      position: 104
      prefix: -Q
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed for read mapping, transcript quantification, and read 
      assignment
    inputBinding:
      position: 104
      prefix: -R
  - id: reads_mapped_to_other_transcript_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of reads with pair mapped to another 
      transcript distribution breakpoints (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -F
  - id: rolling_window_accuracy
    type:
      - 'null'
      - int
    doc: Rolling window size for local accuracy calculation (in bp) when 
      defining low-accuracy regions (LAR)
    inputBinding:
      position: 104
      prefix: -K
  - id: rolling_window_coverage
    type:
      - 'null'
      - int
    doc: Rolling window size for local coverage calculation (in bp) when 
      defining low-coverage regions (LCR)
    inputBinding:
      position: 104
      prefix: -k
  - id: std_dev_fragment_length
    type:
      - 'null'
      - float
    doc: Estimated standard deviation of fragment length needed for transcript 
      quantification (single-end mode only)
    inputBinding:
      position: 104
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 104
      prefix: -t
  - id: transcript_accurate_bases_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of accurate bases distribution breakpoints 
      (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -P
  - id: transcript_covered_bases_breakpoints
    type:
      - 'null'
      - string
    doc: Per-transcript proportion of covered bases distribution breakpoints 
      (specified with x,y,z...)
    inputBinding:
      position: 104
      prefix: -p
  - id: transcript_length_for_end_definition
    type:
      - 'null'
      - float
    doc: Proportion of transcript length for transcript end definition when 
      calculating mean transcript end coverage
    inputBinding:
      position: 104
      prefix: -n
  - id: transcript_length_for_positional_accuracy
    type:
      - 'null'
      - float
    doc: Proportion of transcript length for positional accuracy distribution 
      analysis
    inputBinding:
      position: 104
      prefix: -L
  - id: transcript_length_for_positional_coverage
    type:
      - 'null'
      - float
    doc: Proportion of transcript length for positional relative coverage 
      distribution analysis
    inputBinding:
      position: 104
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
stdout: cats-rf_CATS_rf.out
