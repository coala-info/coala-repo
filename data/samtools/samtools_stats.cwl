cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- stats
label: samtools_stats
doc: 'Collect statistics from an alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file (index needed with a region).
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: region
  type:
  - 'null'
  - string
  doc: Region chr:from-to.
  inputBinding:
    position: 105
- id: coverage
  type:
  - 'null'
  - string
  doc: Coverage distribution min,max,step [1,1000,1].
  inputBinding:
    position: 103
    prefix: --coverage
- id: remove_dups
  type:
  - 'null'
  - boolean
  doc: Exclude from statistics reads marked as duplicates.
  inputBinding:
    position: 103
    prefix: --remove-dups
- id: customized_index_file
  type:
  - 'null'
  - boolean
  doc: Use a customized index file.
  inputBinding:
    position: 103
    prefix: --customized-index-file
- id: required_flag
  type:
  - 'null'
  - string
  doc: Required flag, 0 for unset [0].
  inputBinding:
    position: 103
    prefix: --required-flag
- id: filtering_flag
  type:
  - 'null'
  - string
  doc: Filtering flag, 0 for unset [0].
  inputBinding:
    position: 103
    prefix: --filtering-flag
- id: gc_depth
  type:
  - 'null'
  - float
  doc: The size of GC-depth bins [2e4].
  inputBinding:
    position: 103
    prefix: --GC-depth
- id: insert_size
  type:
  - 'null'
  - int
  doc: Maximum insert size [8000].
  inputBinding:
    position: 103
    prefix: --insert-size
- id: id
  type:
  - 'null'
  - string
  doc: Include only listed read group or sample name.
  inputBinding:
    position: 103
    prefix: --id
- id: read_length
  type:
  - 'null'
  - int
  doc: Include in the statistics only reads with the given read length [-1].
  inputBinding:
    position: 103
    prefix: --read-length
- id: most_inserts
  type:
  - 'null'
  - float
  doc: Report only the main part of inserts [0.99].
  inputBinding:
    position: 103
    prefix: --most-inserts
- id: split_prefix
  type:
  - 'null'
  - string
  doc: Path or string prefix for the files written by --split.
  inputBinding:
    position: 103
    prefix: --split-prefix
- id: trim_quality
  type:
  - 'null'
  - int
  doc: The BWA trimming parameter [0].
  inputBinding:
    position: 103
    prefix: --trim-quality
- id: ref_seq
  type:
  - 'null'
  - File
  doc: Reference sequence (required for GC-depth and mismatches-per-cycle calculation); give its .fai beside it.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --ref-seq
- id: sam
  type:
  - 'null'
  - boolean
  doc: Ignored (input format is auto-detected).
  inputBinding:
    position: 103
    prefix: --sam
- id: split
  type:
  - 'null'
  - string
  doc: Also write statistics to separate files split by tagged field.
  inputBinding:
    position: 103
    prefix: --split
- id: target_regions
  type:
  - 'null'
  - File
  doc: Do stats in these regions only; tab-delimited chr,from,to, 1-based, inclusive.
  inputBinding:
    position: 103
    prefix: --target-regions
- id: sparse
  type:
  - 'null'
  - boolean
  doc: Suppress outputting IS rows where there are no insertions.
  inputBinding:
    position: 103
    prefix: --sparse
- id: remove_overlaps
  type:
  - 'null'
  - boolean
  doc: Remove overlaps of paired-end reads from coverage and base count computations.
  inputBinding:
    position: 103
    prefix: --remove-overlaps
- id: cov_threshold
  type:
  - 'null'
  - int
  doc: Only bases with coverage above this value are included in the target percentage computation [0].
  inputBinding:
    position: 103
    prefix: --cov-threshold
- id: ref_stats
  type:
  - 'null'
  - boolean
  doc: Create statistics on reference data.
  inputBinding:
    position: 103
    prefix: --ref-stats
- id: ref_stats_chunk
  type:
  - 'null'
  - int
  doc: Reference retrieval chunk size, in Mbs, for reference statistics [1].
  inputBinding:
    position: 103
    prefix: --ref-stats-chunk
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: output_filename
  type: string
  doc: Name of the file that receives the statistics (standard output).
  default: stats.txt
outputs:
- id: output
  type: File
  doc: Alignment statistics (SN, FFQ, GCF, IS, ... sections).
  outputBinding:
    glob: $(inputs.output_filename)
- id: split_outputs
  type:
  - 'null'
  - type: array
    items: File
  doc: Per-tag statistics files written with --split.
  outputBinding:
    glob:
    - '*.bamstat'
stdout: $(inputs.output_filename)
