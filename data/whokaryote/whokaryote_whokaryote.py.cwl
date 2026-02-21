cwlVersion: v1.2
class: CommandLineTool
baseCommand: whokaryote
label: whokaryote_whokaryote.py
doc: "A tool for predicting eukaryotic vs prokaryotic origin of metagenomic contigs.\n
  \nTool homepage: https://github.com/LottePronk/whokaryote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whokaryote:1.1.2--pyhdfd78af_0
stdout: whokaryote_whokaryote.py.out
