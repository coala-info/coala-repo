cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnanorm
label: rnanorm
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
stdout: rnanorm.out
