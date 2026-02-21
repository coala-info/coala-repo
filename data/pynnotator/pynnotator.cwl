cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynnotator
label: pynnotator
doc: "A tool for annotating human genetic variants (Note: The provided text is an
  error log and does not contain help information or argument definitions).\n\nTool
  homepage: http://github.com/raonyguimaraes/pynnotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynnotator:2.0--py_0
stdout: pynnotator.out
