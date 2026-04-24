cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - benchmark
label: octopusv_benchmark
doc: "Benchmark structural variation calls against a truth set using GIAB standards.\n\
  \nTool homepage: https://github.com/ylab-hi/octopusV"
inputs:
  - id: truth_file
    type: File
    doc: Path to the truth (ground truth) SVCF file.
    inputBinding:
      position: 1
  - id: call_file
    type: File
    doc: Path to the call (test) SVCF file.
    inputBinding:
      position: 2
  - id: enable_sequence_comparison
    type:
      - 'null'
      - boolean
    doc: Enable sequence similarity comparison if sequences available
    inputBinding:
      position: 103
      prefix: --enable-sequence-compari…
  - id: pass_only
    type:
      - 'null'
      - boolean
    doc: Only consider variants with FILTER == PASS
    inputBinding:
      position: 103
      prefix: --pass-only
  - id: reciprocal_overlap
    type:
      - 'null'
      - float
    doc: Min pct reciprocal overlap
    inputBinding:
      position: 103
      prefix: --reciprocal-overlap
  - id: reference_distance
    type:
      - 'null'
      - int
    doc: Max reference location distance
    inputBinding:
      position: 103
      prefix: --reference-distance
  - id: sequence_similarity
    type:
      - 'null'
      - float
    doc: Min sequence similarity when sequence comparison enabled
    inputBinding:
      position: 103
      prefix: --sequence-similarity
  - id: size_max
    type:
      - 'null'
      - int
    doc: Maximum variant size to consider
    inputBinding:
      position: 103
      prefix: --size-max
  - id: size_min
    type:
      - 'null'
      - int
    doc: Minimum variant size to consider from test calls
    inputBinding:
      position: 103
      prefix: --size-min
  - id: size_similarity
    type:
      - 'null'
      - float
    doc: Min pct size similarity (minsize/maxsize)
    inputBinding:
      position: 103
      prefix: --size-similarity
  - id: type_ignore
    type:
      - 'null'
      - boolean
    doc: Variant types don't need to match to compare
    inputBinding:
      position: 103
      prefix: --type-ignore
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for benchmark results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
