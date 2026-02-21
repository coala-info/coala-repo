cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy
label: hyphy
doc: "HyPhy (Hypothesis Testing using Phylogenies) is a software package for the analysis
  of genetic sequences using techniques in phylogenetics, molecular evolution, and
  machine learning. Note: The provided text contains system error messages regarding
  container image conversion and does not list specific command-line arguments.\n\n
  Tool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.93--hbee74ec_0
stdout: hyphy.out
