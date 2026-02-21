cwlVersion: v1.2
class: CommandLineTool
baseCommand: iva
label: iva
doc: "IVA (Iterative Virus Assembler) is a de novo assembler designed to assemble
  virus genomes from Illumina read pairs.\n\nTool homepage: https://github.com/sanger-pathogens/iva"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iva:1.0.11--py_0
stdout: iva.out
