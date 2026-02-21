cwlVersion: v1.2
class: CommandLineTool
baseCommand: stripepy
label: stripepy-hic_stripepy
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build process for stripepy-hic.\n\nTool homepage: https://github.com/paulsengroup/StripePy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
stdout: stripepy-hic_stripepy.out
