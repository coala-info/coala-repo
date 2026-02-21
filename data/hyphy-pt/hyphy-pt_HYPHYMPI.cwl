cwlVersion: v1.2
class: CommandLineTool
baseCommand: HYPHYMPI
label: hyphy-pt_HYPHYMPI
doc: "HyPhy (Hypothesis Testing using Phylogenies) is a software package for the analysis
  of genetic sequences using techniques in phylogenetics, molecular evolution, and
  machine learning. (Note: The provided help text contains system errors and does
  not list specific arguments.)\n\nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-pt:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-pt_HYPHYMPI.out
