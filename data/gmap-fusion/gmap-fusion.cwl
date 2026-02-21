cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmap-fusion
label: gmap-fusion
doc: "The provided text does not contain help information or usage instructions for
  gmap-fusion; it contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/GMAP-fusion/GMAP-fusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap-fusion:0.4.0--hdfd78af_3
stdout: gmap-fusion.out
