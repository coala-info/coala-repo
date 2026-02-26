cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merfishtools
  - diffexp
label: merfishtools_diffexp
doc: "Test for differential expression between two groups of cells.\n\nTool homepage:
  https://merfishtools.github.io"
inputs:
  - id: group1
    type: File
    doc: Path to expression PMFs for group of cells.
    inputBinding:
      position: 1
  - id: group2
    type: File
    doc: Path to expression PMFs for group of cells.
    inputBinding:
      position: 2
  - id: max_null_log2fc
    type:
      - 'null'
      - float
    doc: Maximum absolute log2 fold change considered as no differential 
      expression
    default: 1.0
    inputBinding:
      position: 103
      prefix: --max-null-log2fc
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: Pseudocounts to add to means before fold change calculation
    default: 1.0
    inputBinding:
      position: 103
      prefix: --pseudocounts
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: cdf_file
    type:
      - 'null'
      - File
    doc: Path to write CDFs of log2 fold changes to.
    outputBinding:
      glob: $(inputs.cdf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
