cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse
label: bedparse
doc: "A tool for parsing and manipulating BED files. (Note: The provided input text
  contained container build errors rather than help documentation; arguments could
  not be extracted from the source text.)\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse.out
