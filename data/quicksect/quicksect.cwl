cwlVersion: v1.2
class: CommandLineTool
baseCommand: quicksect
label: quicksect
doc: "A fast interval intersection library for Python. (Note: The provided text is
  an error log from a container build process and does not contain CLI help information
  or argument definitions.)\n\nTool homepage: https://github.com/brentp/quicksect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quicksect:0.2.2--py312h0fa9677_11
stdout: quicksect.out
