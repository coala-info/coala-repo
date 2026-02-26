cwlVersion: v1.2
class: CommandLineTool
baseCommand: predex comparison
label: predex_comparison
doc: "Perform comparisons between samples based on a design matrix and a specified
  column.\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs:
  - id: column
    type: string
    doc: Column name to make comparisons with
    inputBinding:
      position: 101
      prefix: --column
  - id: design
    type: File
    doc: Design matrix with sample data
    inputBinding:
      position: 101
      prefix: --design
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
