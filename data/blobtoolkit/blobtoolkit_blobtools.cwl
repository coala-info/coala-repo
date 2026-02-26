cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools
label: blobtoolkit_blobtools
doc: "assembly exploration, QC and filtering.\n\nTool homepage: https://github.com/blobtoolkit/blobtoolkit"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: blobtools command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
stdout: blobtoolkit_blobtools.out
