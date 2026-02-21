cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - jcvi.graphics.synteny
label: jcvi_jcvi.graphics.synteny
doc: "A tool for synteny visualization from the JCVI library. Note: The provided help
  text contains a system error message and does not list specific command-line arguments.\n
  \nTool homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.graphics.synteny.out
