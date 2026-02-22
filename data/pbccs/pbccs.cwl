cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccs
label: pbccs
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a lack of disk space while attempting
  to run a Singularity container for pbccs.\n\nTool homepage: https://github.com/PacificBiosciences/unanimity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbccs:6.4.0--h9ee0642_0
stdout: pbccs.out
