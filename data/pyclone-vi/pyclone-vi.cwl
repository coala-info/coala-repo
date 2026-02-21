cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyclone-vi
label: pyclone-vi
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/Roth-Lab/pyclone-vi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0
stdout: pyclone-vi.out
