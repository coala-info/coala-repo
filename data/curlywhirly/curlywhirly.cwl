cwlVersion: v1.2
class: CommandLineTool
baseCommand: curlywhirly
label: curlywhirly
doc: "CurlyWhirly is a 3D data visualization tool, typically used for genomic data.
  (Note: The provided text is a container execution error log and does not contain
  help documentation or argument definitions).\n\nTool homepage: https://ics.hutton.ac.uk/curlywhirly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curlywhirly:1.17.08.31--0
stdout: curlywhirly.out
