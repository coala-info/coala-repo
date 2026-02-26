cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-filter-file
label: finaletoolkit_filter-file
doc: "Filters a BED/BAM/CRAM file so that all reads/intervals, when applicable,are
  in mapped pairs, exceed a certain MAPQ, are not flagged for quality, are read1,
  are not secondary or supplementary alignments, are within/excluding specified intervals,
  and are on the same reference sequence as the mate.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to BAM file.
    inputBinding:
      position: 1
  - id: blacklist_file
    type:
      - 'null'
      - File
    doc: Only output alignments outside of the intervals in this BED file will 
      be included.
    inputBinding:
      position: 102
      prefix: --blacklist-file
  - id: fraction_high
    type:
      - 'null'
      - int
    doc: Deprecated alias for --max-length
    inputBinding:
      position: 102
      prefix: --fraction-high
  - id: fraction_low
    type:
      - 'null'
      - int
    doc: Deprecated alias for --min-length
    inputBinding:
      position: 102
      prefix: --fraction-low
  - id: intersect_policy
    type:
      - 'null'
      - string
    doc: Specifies what policy is used to include/exclude fragments in the given
      interval. See User Guide for more information.
    inputBinding:
      position: 102
      prefix: --intersect-policy
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: whitelist_file
    type:
      - 'null'
      - File
    doc: Only output alignments overlapping the intervals in this BED file will 
      be included.
    inputBinding:
      position: 102
      prefix: --whitelist-file
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED/BAM/CRAM file path.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
