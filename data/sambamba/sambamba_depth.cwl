cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-depth
label: sambamba_depth
doc: "Calculate depth of coverage for BAM files.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: mode
    type: string
    doc: 'The mode of operation: region, window, or base.'
    inputBinding:
      position: 1
  - id: input_bam
    type:
      type: array
      items: File
    doc: Input BAM file(s). Must be coordinate-sorted and indexed.
    inputBinding:
      position: 2
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Add additional column of y/n instead of skipping records not satisfying
      the criteria.
    inputBinding:
      position: 103
      prefix: --annotate
  - id: combined
    type:
      - 'null'
      - boolean
    doc: Output combined statistics for all samples.
    inputBinding:
      position: 103
      prefix: --combined
  - id: cov_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: Multiple thresholds can be provided, for each one an extra column will 
      be added, the percentage of bases in the region where coverage is more 
      than this value.
    inputBinding:
      position: 103
      prefix: --cov-threshold
  - id: filter
    type:
      - 'null'
      - string
    doc: Set custom filter for alignments.
    default: "'mapping_quality > 0 and not duplicate and not failed_quality_control'"
    inputBinding:
      position: 103
      prefix: --filter
  - id: fix_mate_overlaps
    type:
      - 'null'
      - boolean
    doc: Detect overlaps of mate reads and handle them on per-base basis.
    inputBinding:
      position: 103
      prefix: --fix-mate-overlaps
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum mean coverage for output.
    inputBinding:
      position: 103
      prefix: --max-coverage
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Don't count bases with lower base quality.
    inputBinding:
      position: 103
      prefix: --min-base-quality
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum mean coverage for output.
    default: 0 for region/window, 1 for base
    inputBinding:
      position: 103
      prefix: --min-coverage
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: overlap
    type:
      - 'null'
      - int
    doc: Overlap of successive windows, in bp.
    default: 0
    inputBinding:
      position: 103
      prefix: --overlap
  - id: regions
    type:
      - 'null'
      - string
    doc: List or regions of interest or a single region in form chr:beg-end.
    inputBinding:
      position: 103
      prefix: --regions
  - id: report_zero_coverage
    type:
      - 'null'
      - boolean
    doc: Don't skip zero coverage bases (DEPRECATED, use --min-coverage=0 
      instead).
    inputBinding:
      position: 103
      prefix: --report-zero-coverage
  - id: window_size
    type: int
    doc: Breadth of the window, in bp.
    inputBinding:
      position: 103
      prefix: --window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
