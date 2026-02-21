cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteinortho
label: proteinortho
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://gitlab.com/paulklemm_PHD/proteinortho/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteinortho:6.3.6--h2b77389_0
stdout: proteinortho.out
