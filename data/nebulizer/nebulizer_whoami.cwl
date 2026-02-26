cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - whoami
label: nebulizer_whoami
doc: "Print user details associated with API key.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY user identifier
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_whoami.out
