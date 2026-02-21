cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin
label: ppanggolin
doc: "Pangenome analysis tool\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin.out
