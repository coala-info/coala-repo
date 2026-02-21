cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxtastic
label: taxtastic
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/fhcrc/taxtastic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic.out
