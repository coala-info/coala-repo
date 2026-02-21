cwlVersion: v1.2
class: CommandLineTool
baseCommand: savana
label: savana
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
stdout: savana.out
