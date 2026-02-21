cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jcvi
  - formats
  - fasta
label: jcvi_jcvi.formats.fasta
doc: "JCVI utility for FASTA format manipulation. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  tool arguments.)\n\nTool homepage: http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.formats.fasta.out
