cwlVersion: v1.2
class: CommandLineTool
baseCommand: multipletau
label: python3-multipletau
doc: A Python implementation of the multiple-tau autocorrelation algorithm.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-multipletau:v0.1.7ds-1-deb_cv1
stdout: python3-multipletau.out
