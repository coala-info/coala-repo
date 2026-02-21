cwlVersion: v1.2
class: CommandLineTool
baseCommand: snap-aligner
label: snap-aligner
doc: "The provided text is a container engine error log and does not contain help
  documentation or usage instructions for snap-aligner.\n\nTool homepage: http://snap.cs.berkeley.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snap-aligner:2.0.5--h077b44d_2
stdout: snap-aligner.out
