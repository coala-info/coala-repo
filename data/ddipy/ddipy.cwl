cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddipy
label: ddipy
doc: "A Python client for the OmicsDI API (Note: The provided text contains error
  logs from a container runtime and does not include the tool's help documentation.
  No arguments could be extracted.)\n\nTool homepage: https://github.com/OmicsDI/ddipy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddipy:0.0.5--py_0
stdout: ddipy.out
