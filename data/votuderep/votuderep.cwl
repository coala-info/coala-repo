cwlVersion: v1.2
class: CommandLineTool
baseCommand: votuderep
label: votuderep
doc: "The provided text does not contain help information for the tool; it contains
  log messages and a fatal error related to a container build process.\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/votuderep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
stdout: votuderep.out
