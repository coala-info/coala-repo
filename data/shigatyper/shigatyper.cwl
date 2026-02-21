cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigatyper
label: shigatyper
doc: "Shigella serotyping from Illumina paired-end reads\n\nTool homepage: https://github.com/CFSAN-Biostatistics/shigatyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigatyper:2.0.5--pyhdfd78af_0
stdout: shigatyper.out
