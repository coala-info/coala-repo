cwlVersion: v1.2
class: CommandLineTool
baseCommand: noise2read
label: noise2read
doc: "A tool for noise reduction in sequencing reads. (Note: The provided text contains
  a system error message rather than help documentation; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/Jappy0/noise2read"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noise2read:0.3.0--pyhdfd78af_0
stdout: noise2read.out
