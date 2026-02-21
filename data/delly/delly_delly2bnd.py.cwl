cwlVersion: v1.2
class: CommandLineTool
baseCommand: delly_delly2bnd.py
label: delly_delly2bnd.py
doc: "A tool for converting Delly deletions to breakends (BND). Note: The provided
  help text contains system error messages and does not list command-line arguments.\n
  \nTool homepage: https://github.com/dellytools/delly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delly:1.7.2--h4d20210_0
stdout: delly_delly2bnd.py.out
