cwlVersion: v1.2
class: CommandLineTool
baseCommand: rna-cd
label: rna-cd
doc: "RNA-CD tool (Note: The provided text contains container build logs and error
  messages rather than CLI help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/LUMC/rna_cd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rna-cd:0.2.0--py_0
stdout: rna-cd.out
