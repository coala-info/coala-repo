cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx print-metadata
label: pypgx_print-metadata
doc: "Print the metadata of specified archive.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: input
    type: File
    doc: Input archive file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_print-metadata.out
