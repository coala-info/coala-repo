cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyasr
label: pyasr
doc: "The provided text contains error logs related to a container build process and
  does not include the help documentation or usage instructions for the pyasr tool.
  Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/Zsailer/pyasr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyasr:0.6.1--py_0
stdout: pyasr.out
