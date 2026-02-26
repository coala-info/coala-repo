cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - delete
label: bigsi_delete
doc: "Deletes a BigSI index.\n\nTool homepage: https://github.com/Phelimb/BIGSI"
inputs:
  - id: config
    type: File
    doc: Path to the BigSI configuration file.
    inputBinding:
      position: 101
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_delete.out
