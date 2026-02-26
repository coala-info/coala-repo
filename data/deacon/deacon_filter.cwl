cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - filter
label: deacon_filter
doc: "Retain or deplete sequence records with sufficient minimizer hits to an indexed
  query\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: index
    type: File
    doc: Path to minimizer index file
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: Optional path to fastx file (or - for stdin)
    default: '-'
    inputBinding:
      position: 2
  - id: input2
    type:
      - 'null'
      - File
    doc: Optional path to second paired fastx file (or - for interleaved stdin)
    inputBinding:
      position: 3
  - id: abs_threshold
    type:
      - 'null'
      - int
    doc: Minimum absolute number of minimizer hits for a match
    default: 2
    inputBinding:
      position: 104
      prefix: --abs-threshold
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Output compression level (1-9 for gz & xz; 1-22 for zstd)
    default: 2
    inputBinding:
      position: 104
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for output compression (0 = auto)
    default: 0
    inputBinding:
      position: 104
      prefix: --compression-threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output sequences with minimizer hits to stderr
    inputBinding:
      position: 104
      prefix: --debug
  - id: deplete
    type:
      - 'null'
      - boolean
    doc: Discard matching sequences (invert filtering behaviour)
    inputBinding:
      position: 104
      prefix: --deplete
  - id: prefix_length
    type:
      - 'null'
      - int
    doc: Search only the first N nucleotides per sequence (0 = entire sequence)
    default: 0
    inputBinding:
      position: 104
      prefix: --prefix-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress reporting
    inputBinding:
      position: 104
      prefix: --quiet
  - id: rel_threshold
    type:
      - 'null'
      - float
    doc: Minimum relative proportion (0.0-1.0) of minimizer hits for a match
    default: 0.01
    inputBinding:
      position: 104
      prefix: --rel-threshold
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Replace sequence headers with incrementing numbers
    inputBinding:
      position: 104
      prefix: --rename
  - id: rename_random
    type:
      - 'null'
      - boolean
    doc: Replace sequence headers with incrementing numbers and random suffixes
    inputBinding:
      position: 104
      prefix: --rename-random
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (0 = auto)
    default: 8
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output fastx file (stdout if not specified; detects .gz and 
      .zst)
    outputBinding:
      glob: $(inputs.output)
  - id: output2
    type:
      - 'null'
      - File
    doc: Optional path to second paired output fastx file (detects .gz and .zst)
    outputBinding:
      glob: $(inputs.output2)
  - id: summary
    type:
      - 'null'
      - File
    doc: Path to JSON summary output file
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
