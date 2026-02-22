cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa
label: autometa
doc: "Automated extraction of microbial genomes from metagenomes\n\nTool homepage:
  https://github.com/KwanLab/Autometa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
stdout: autometa.out
