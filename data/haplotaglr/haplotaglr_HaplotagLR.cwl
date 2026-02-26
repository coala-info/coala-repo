cwlVersion: v1.2
class: CommandLineTool
baseCommand: HaplotagLR
label: haplotaglr_HaplotagLR
doc: "A tool for haplotagging individual long reads using pre-phased haplotypes.\n\
  \nTool homepage: https://github.com/Boyle-Lab/HaplotagLR.git"
inputs:
  - id: mode
    type: string
    doc: 'Choose which mode to run: {haplotag}'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotaglr:1.1.13--pyhdfd78af_0
stdout: haplotaglr_HaplotagLR.out
