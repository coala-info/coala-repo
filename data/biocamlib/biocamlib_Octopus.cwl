cwlVersion: v1.2
class: CommandLineTool
baseCommand: Octopus
label: biocamlib_Octopus
doc: "Octopus version 6, compiled against BiOCamLib version 245. A tool by Paolo Ribeca.\n
  \nTool homepage: https://github.com/PaoloRibeca/BiOCamLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocamlib:1.0.0--h9ee0642_0
stdout: biocamlib_Octopus.out
