cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanomotif
  - MTase-linker
label: nanomotif_MTase-linker
doc: "MTase-linker commands\n\nTool homepage: https://pypi.org/project/nanomotif/"
inputs:
  - id: command
    type: string
    doc: MTase-linker commands
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
stdout: nanomotif_MTase-linker.out
