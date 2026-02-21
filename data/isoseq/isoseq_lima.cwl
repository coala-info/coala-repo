cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - lima
label: isoseq_lima
doc: "The provided text does not contain help information or a description for the
  tool; it contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq_lima.out
