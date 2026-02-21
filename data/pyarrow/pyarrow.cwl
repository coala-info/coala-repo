cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyarrow
label: pyarrow
doc: "The provided text does not contain help information or argument definitions.
  It appears to be a log of a failed container build process for the pyarrow image.\n
  \nTool homepage: https://github.com/lance-format/lance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyarrow:4.0.1
stdout: pyarrow.out
