cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyaavf
label: pyaavf
doc: "A Python library and command-line utility for parsing and manipulating Allelic
  Alternative Variation Format (AAVF) files.\n\nTool homepage: http://github.com/winhiv/PyAAVF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyaavf:0.1.0--py_0
stdout: pyaavf.out
