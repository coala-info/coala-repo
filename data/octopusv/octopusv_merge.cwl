cwlVersion: v1.2
class: CommandLineTool
baseCommand: octopusv_merge
label: octopusv_merge
doc: "Merge multiple SVCF files based on specified strategy with consistent SOURCES
  and SAMPLE ordering.\n\nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of input SVCF files to merge.
    inputBinding:
      position: 1
  - id: bnd_delta
    type:
      - 'null'
      - int
    doc: Position uncertainty threshold for BND events (in base pairs).
    default: 50
    inputBinding:
      position: 102
      prefix: --bnd-delta
  - id: caller_names
    type:
      - 'null'
      - string
    doc: Comma-separated caller names (only for caller mode). Must match input 
      file count.
    inputBinding:
      position: 102
      prefix: --caller-names
  - id: exact_support
    type:
      - 'null'
      - int
    doc: Exact number of files that must support an SV.
    inputBinding:
      position: 102
      prefix: --exact-support
  - id: expression
    type:
      - 'null'
      - string
    doc: Logical expression for complex file combinations (e.g., '(A AND B) AND 
      NOT (C OR D)')
    inputBinding:
      position: 102
      prefix: --expression
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input SVCF files to merge.
    inputBinding:
      position: 102
      prefix: --input-file
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: Apply intersection strategy for merging.
    inputBinding:
      position: 102
      prefix: --intersect
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum allowed distance between start or end positions for merging 
      events.
    default: 50
    inputBinding:
      position: 102
      prefix: --max-distance
  - id: max_length_ratio
    type:
      - 'null'
      - float
    doc: Maximum allowed ratio between event lengths for merging events.
    default: 1.3
    inputBinding:
      position: 102
      prefix: --max-length-ratio
  - id: max_support
    type:
      - 'null'
      - int
    doc: Maximum number of files that can support an SV.
    inputBinding:
      position: 102
      prefix: --max-support
  - id: min_jaccard
    type:
      - 'null'
      - float
    doc: Minimum required Jaccard index for overlap to merge events.
    default: 0.7
    inputBinding:
      position: 102
      prefix: --min-jaccard
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum number of files that must support an SV.
    inputBinding:
      position: 102
      prefix: --min-support
  - id: mode
    type:
      - 'null'
      - string
    doc: "Merge mode: 'caller' for same sample different callers, 'sample' for different
      samples."
    default: caller
    inputBinding:
      position: 102
      prefix: --mode
  - id: sample_names
    type:
      - 'null'
      - string
    doc: Comma-separated sample names (only for sample mode). Must match input 
      file count.
    inputBinding:
      position: 102
      prefix: --sample-names
  - id: specific
    type:
      - 'null'
      - File
    doc: Extract SVs that are specifically supported by provided files.
    inputBinding:
      position: 102
      prefix: --specific
  - id: tra_delta
    type:
      - 'null'
      - int
    doc: Position uncertainty threshold for TRA events (in base pairs).
    default: 50
    inputBinding:
      position: 102
      prefix: --tra-delta
  - id: tra_min_overlap
    type:
      - 'null'
      - float
    doc: Minimum overlap ratio for TRA events.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --tra-min-overlap
  - id: tra_strand_consistency
    type:
      - 'null'
      - boolean
    doc: Whether to require strand consistency for TRA events.
    default: true
    inputBinding:
      position: 102
      prefix: --tra-strand-consistency
  - id: union
    type:
      - 'null'
      - boolean
    doc: Apply union strategy for merging.
    inputBinding:
      position: 102
      prefix: --union
  - id: upsetr
    type:
      - 'null'
      - boolean
    doc: Generate UpSet plot visualization of input file intersections.
    inputBinding:
      position: 102
      prefix: --upsetr
outputs:
  - id: output_file
    type: File
    doc: Output file for merged SV data.
    outputBinding:
      glob: $(inputs.output_file)
  - id: upsetr_output
    type:
      - 'null'
      - File
    doc: Output path for UpSet plot. If not provided, will use output_file 
      basename with _upset.png suffix.
    outputBinding:
      glob: $(inputs.upsetr_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
