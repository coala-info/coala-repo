cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfishtools multidiffexp
label: merfishtools_multidiffexp
doc: "Test for differential expression between multiple groups of cells.\n\nTool homepage:
  https://merfishtools.github.io"
inputs:
  - id: groups
    type:
      type: array
      items: File
    doc: Paths to expression PMFs for groups of cells.
    inputBinding:
      position: 1
  - id: max_null_cv
    type:
      - 'null'
      - float
    doc: Maximum coefficient of variation (CV) considered as no differential 
      expression
    inputBinding:
      position: 102
      prefix: --max-null-cv
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: Pseudocounts to add to means before CV calculation
    inputBinding:
      position: 102
      prefix: --pseudocounts
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: cdf_file
    type:
      - 'null'
      - File
    doc: Path to write CDFs of CVs to.
    outputBinding:
      glob: $(inputs.cdf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
