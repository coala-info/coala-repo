cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy check
label: sketchy_check
doc: "Check match between sketch and genotype file\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs:
  - id: genotypes
    type: File
    doc: Genotype file to validate with sketch file
    inputBinding:
      position: 101
      prefix: --genotypes
  - id: reference
    type: File
    doc: 'Sketch file, format: Mash (.msh) or Finch (.fsh)'
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
stdout: sketchy_check.out
