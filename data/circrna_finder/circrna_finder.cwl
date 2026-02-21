cwlVersion: v1.2
class: CommandLineTool
baseCommand: circrna_finder
label: circrna_finder
doc: "A tool for identifying circular RNAs from RNA-seq data.\n\nTool homepage: https://github.com/orzechoj/circRNA_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circrna_finder:1.2--pl5321hdfd78af_1
stdout: circrna_finder.out
