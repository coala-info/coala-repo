cwlVersion: v1.2
class: CommandLineTool
baseCommand: reffinder
label: reffinder
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a log of a failed container build/pull process.\n\nTool
  homepage: https://github.com/ANGSD/refFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reffinder:0.81--h5ca1c30_4
stdout: reffinder.out
