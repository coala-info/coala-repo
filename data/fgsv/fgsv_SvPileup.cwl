cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgsv
  - SvPileup
label: fgsv_SvPileup
doc: "Collates pileups of reads over breakpoint events.\n\nTool homepage: https://github.com/fulcrumgenomics/fgsv"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: input_bam
    type: File
    doc: The input query sorted or grouped BAM
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: Minimum severity log-level to emit.
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_aligned_segment_inner_distance
    type:
      - 'null'
      - int
    doc: The maximum inner distance between two segments of a split read mapping
    default: 100
    inputBinding:
      position: 101
      prefix: --max-aligned-segment-inner-distance
  - id: max_read_pair_inner_distance
    type:
      - 'null'
      - int
    doc: The maximum inner distance for normal read pair
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-read-pair-inner-distance
  - id: min_primary_mapping_quality
    type:
      - 'null'
      - int
    doc: The minimum mapping quality for primary alignments
    default: 30
    inputBinding:
      position: 101
      prefix: --min-primary-mapping-quality
  - id: min_supplementary_mapping_quality
    type:
      - 'null'
      - int
    doc: The minimum mapping quality for supplementary alignments
    default: 18
    inputBinding:
      position: 101
      prefix: --min-supplementary-mapping-quality
  - id: min_unique_bases_to_add
    type:
      - 'null'
      - int
    doc: 'The minimum # of uncovered query bases needed to add a supplemental alignment'
    default: 20
    inputBinding:
      position: 101
      prefix: --min-unique-bases-to-add
  - id: output_prefix
    type: string
    doc: The output path prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for SAM/BAM reading.
    default: SILENT
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: slop
    type:
      - 'null'
      - int
    doc: "The number of bases of slop to allow when determining which records to track
      for the left\nor right side of an aligned segment when merging segments."
    default: 5
    inputBinding:
      position: 101
      prefix: --slop
  - id: targets_bed
    type:
      - 'null'
      - File
    doc: Optional bed file of target regions
    inputBinding:
      position: 101
      prefix: --targets-bed
  - id: targets_bed_requirement
    type:
      - 'null'
      - string
    doc: "Requirement on if each side of the breakpoint must overlap a target. Will
      always annotate\neach side of the breakpoint."
    default: AnnotateOnly
    inputBinding:
      position: 101
      prefix: --targets-bed-requirement
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
stdout: fgsv_SvPileup.out
