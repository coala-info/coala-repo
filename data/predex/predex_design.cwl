cwlVersion: v1.2
class: CommandLineTool
baseCommand: predex_design
label: predex_design
doc: "Design experiment based on input count matrix.\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs:
  - id: input_files
    type: File
    doc: Input files (count matrix, e.g., HTSeq)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: current
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
stdout: predex_design.out
