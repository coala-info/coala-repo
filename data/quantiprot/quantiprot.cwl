cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantiprot
label: quantiprot
doc: "A tool for quantitative analysis of protein sequences. (Note: The provided text
  contains container runtime error messages rather than CLI help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://git.e-science.pl/wdyrka/quantiprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantiprot:0.2.5--pyh7cba7a3_0
stdout: quantiprot.out
