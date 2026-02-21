cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - jcvi.graphics.karyotype
label: jcvi_jcvi.graphics.karyotype
doc: "Karyotype visualization tool (Note: The provided help text contains only system
  error messages regarding container execution and disk space, so no arguments could
  be extracted).\n\nTool homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.graphics.karyotype.out
