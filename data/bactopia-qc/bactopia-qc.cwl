cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-qc
label: bactopia-qc
doc: "A tool for quality control of sequencing reads (Note: The provided text contains
  system error messages regarding disk space and container execution rather than help
  documentation; therefore, specific arguments could not be extracted from this input).\n\
  \nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
stdout: bactopia-qc.out
