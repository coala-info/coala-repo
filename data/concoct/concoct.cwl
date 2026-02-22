cwlVersion: v1.2
class: CommandLineTool
baseCommand: concoct
label: concoct
doc: "CONCOCT (Clustering Contigs with Coverage and Composition) is a program for
  clustering contigs from metagenomes.\n\nTool homepage: https://github.com/BinPro/CONCOCT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/concoct:1.1.0--py311hdfb91c2_8
stdout: concoct.out
