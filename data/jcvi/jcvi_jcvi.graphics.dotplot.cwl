cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jcvi
  - graphics
  - dotplot
label: jcvi_jcvi.graphics.dotplot
doc: "The provided text does not contain help information as it is an error log reporting
  a failure to build or run the container (no space left on device). No arguments
  could be extracted from the input text.\n\nTool homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.graphics.dotplot.out
