cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikado
label: mikado
doc: "Mikado is a lightweight Python3 pipeline whose purpose is to facilitate the
  identification of expressed loci from RNA-Seq data and to select the best model
  for each locus.\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado.out
