cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - jcvi.formats.gff
label: jcvi_jcvi.formats.gff
doc: "The provided text does not contain help information; it contains system error
  logs regarding a container execution failure (no space left on device).\n\nTool
  homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.formats.gff.out
