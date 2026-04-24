cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - ArtificialFastqGenerator.jar
label: artfastqgenerator
doc: ArtificialFastqGenerator generates artificial FASTQ files from a reference genome,
  simulating coverage biases and quality scores.
inputs:
  - id: coverage_mean_gc_content_spread
    type:
      - 'null'
      - float
    doc: The spread of coverage mean given GC content.
    inputBinding:
      position: 101
      prefix: -CMGCS
  - id: coverage_mean_peak
    type:
      - 'null'
      - float
    doc: The peak coverage mean for a region.
    inputBinding:
      position: 101
      prefix: -CMP
  - id: coverage_mean_peak_gc_content
    type:
      - 'null'
      - float
    doc: The GC content for regions with peak coverage mean.
    inputBinding:
      position: 101
      prefix: -CMPGC
  - id: coverage_sd
    type:
      - 'null'
      - float
    doc: The coverage standard deviation divided by the mean.
    inputBinding:
      position: 101
      prefix: -CSD
  - id: end_sequence_identifier
    type:
      - 'null'
      - string
    doc: Prefix of the sequence identifier in the reference where read generation
      should stop (default = end of file).
    inputBinding:
      position: 101
      prefix: -E
  - id: fastq1_for_quality_scores
    type:
      - 'null'
      - File
    doc: First fastq file to use for real quality scores (required if useRealQualityScores
      = true).
    inputBinding:
      position: 101
      prefix: -F1
  - id: fastq2_for_quality_scores
    type:
      - 'null'
      - File
    doc: Second fastq file to use for real quality scores (required if useRealQualityScores
      = true).
    inputBinding:
      position: 101
      prefix: -F2
  - id: gc_content_based_coverage
    type:
      - 'null'
      - boolean
    doc: Whether nucleobase coverage is biased by GC content.
    inputBinding:
      position: 101
      prefix: -GCC
  - id: gc_content_region_size
    type:
      - 'null'
      - int
    doc: Region size in nucleobases for which to calculate GC content.
    inputBinding:
      position: 101
      prefix: -GCR
  - id: log_region_stats
    type:
      - 'null'
      - int
    doc: The region size as a multiple of -NBS for which summary coverage statistics
      are recorded.
    inputBinding:
      position: 101
      prefix: -L
  - id: nucleobase_buffer_size
    type:
      - 'null'
      - int
    doc: The number of reference sequence nucleobases to buffer in memory.
    inputBinding:
      position: 101
      prefix: -N
  - id: output_format
    type:
      - 'null'
      - string
    doc: "'default': standard fastq output; 'debug_nucleobases(_nuc|read_ids)': debugging."
    inputBinding:
      position: 101
      prefix: -OF
  - id: read_length
    type:
      - 'null'
      - int
    doc: The length of each read.
    inputBinding:
      position: 101
      prefix: -RL
  - id: reads_containing_n_filter
    type:
      - 'null'
      - int
    doc: Filter out no 'N-containing' reads (0), 'all-N' reads (1), 'at-least-1-N'
      reads (2).
    inputBinding:
      position: 101
      prefix: -RCNF
  - id: reference_genome_path
    type: File
    doc: Reference genome sequence file.
    inputBinding:
      position: 101
      prefix: -R
  - id: simulate_error_in_read
    type:
      - 'null'
      - boolean
    doc: Whether to simulate error in the read based on the quality scores.
    inputBinding:
      position: 101
      prefix: -SE
  - id: start_sequence_identifier
    type: string
    doc: Prefix of the sequence identifier in the reference after which read generation
      should begin.
    inputBinding:
      position: 101
      prefix: -S
  - id: template_length_mean
    type:
      - 'null'
      - int
    doc: The mean DNA template length.
    inputBinding:
      position: 101
      prefix: -TLM
  - id: template_length_sd
    type:
      - 'null'
      - int
    doc: The standard deviation of the DNA template length.
    inputBinding:
      position: 101
      prefix: -TLSD
  - id: use_real_quality_scores
    type:
      - 'null'
      - boolean
    doc: Whether to use real quality scores from existing fastq files or set all to
      the maximum.
    inputBinding:
      position: 101
      prefix: -URQS
  - id: x_start
    type:
      - 'null'
      - int
    doc: The first read's X coordinate.
    inputBinding:
      position: 101
      prefix: -X
  - id: y_start
    type:
      - 'null'
      - int
    doc: The first read's Y coordinate.
    inputBinding:
      position: 101
      prefix: -Y
outputs:
  - id: output_path
    type: File
    doc: Path for the artificial fastq and log files, including their base name.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/artfastqgenerator:v0.0.20150519-3-deb_cv1
