cwlVersion: v1.2
class: CommandLineTool
baseCommand: troika-tb
label: troika-tb
doc: "A tool for TB analysis (detailed description and arguments not available in
  the provided log text).\n\nTool homepage: https://github.com/kristyhoran/troika"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/troika-tb:0.0.5--py_0
stdout: troika-tb.out
