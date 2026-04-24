cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - frequent-sets
label: lyner_frequent-sets
doc: "Find frequent itemsets in a binary matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Path to the input binary matrix file (e.g., CSV, TSV).
    inputBinding:
      position: 1
  - id: min_support
    type:
      - 'null'
      - float
    doc: Minimum support threshold for itemsets (0.0 to 1.0).
    inputBinding:
      position: 102
      prefix: --min-support
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for frequent itemsets.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
