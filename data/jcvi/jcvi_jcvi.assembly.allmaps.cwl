cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jcvi
  - assembly
  - allmaps
label: jcvi_jcvi.assembly.allmaps
doc: "ALLMAPS: robust assembly scaffolding using multiple maps (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.assembly.allmaps.out
