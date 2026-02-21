cwlVersion: v1.2
class: CommandLineTool
baseCommand: start-asap
label: start-asap
doc: "ASAP: Automated Single-cell Analysis Pipeline\n\nTool homepage: http://github.com/quadram-institute-bioscience/start-asap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/start-asap:1.3.0--hdfd78af_1
stdout: start-asap.out
