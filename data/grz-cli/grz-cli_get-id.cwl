cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grz-cli
  - get-id
label: grz-cli_get-id
doc: "Get ID from metadata\n\nTool homepage: https://pypi.org/project/grz-cli"
inputs:
  - id: metadata
    type: string
    doc: Metadata to get ID from
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
stdout: grz-cli_get-id.out
