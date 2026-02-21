cwlVersion: v1.2
class: CommandLineTool
baseCommand: bialign_bialign.py
label: bialign_bialign.py
doc: "A tool for bi-directional alignment (Note: The provided help text contains system
  error messages regarding container extraction and does not list specific tool arguments).\n
  \nTool homepage: https://github.com/s-will/BiAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bialign:0.3--py310hec16e2b_0
stdout: bialign_bialign.py.out
