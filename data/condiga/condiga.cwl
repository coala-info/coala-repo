cwlVersion: v1.2
class: CommandLineTool
baseCommand: condiga
label: condiga
doc: "The provided text does not contain help information or usage instructions for
  the tool 'condiga'. It consists of system error messages related to container image
  conversion and disk space issues.\n\nTool homepage: https://github.com/metagentools/ConDiGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/condiga:0.2.2--pyhdfd78af_0
stdout: condiga.out
