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
    inputBinding:
      position: 103
      prefix: --max-null-log2fc
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: Pseudocounts to add to means before fold change calculation
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
  - id: cdf_file_path
    type: string
    doc: Output or path parameter `cdf_file_path`
    inputBinding:
      position: 104
      prefix: --cdf-file
outputs:
  - id: cdf_file
    type:
      - 'null'
      - File
    doc: Path to write CDFs of log2 fold changes to.
    outputBinding:
      glob: $(inputs.cdf_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
