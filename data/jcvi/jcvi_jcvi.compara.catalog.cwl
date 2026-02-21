cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - jcvi.compara.catalog
label: jcvi_jcvi.compara.catalog
doc: "Synteny visualization and analysis. (Note: The provided help text contains system
  error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.compara.catalog.out
