cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_hybrid
label: idba_idba_hybrid
doc: "Iterative De Bruijn Graph Assembler for hybrid sequencing data.\n\nTool homepage:
  https://github.com/loneknightpy/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba_idba_hybrid.out
