cwlVersion: v1.2
class: CommandLineTool
baseCommand: mb
label: mrbayes
doc: "MrBayes is a program for Bayesian inference and model selection across a wide
  spectrum of phylogenetic and evolutionary models.\n\nTool homepage: http://mrbayes.sourceforge.net"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Nexus file containing the data and MrBayes blocks
    inputBinding:
      position: 1
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Force interactive mode
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrbayes:3.2.7--hd0d793b_7
stdout: mrbayes.out
