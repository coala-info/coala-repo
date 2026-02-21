cwlVersion: v1.2
class: CommandLineTool
baseCommand: nonpareil
label: nonpareil
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log regarding a container execution failure
  (no space left on device).\n\nTool homepage: http://nonpareil.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nonpareil:3.5.5--r44h077b44d_2
stdout: nonpareil.out
