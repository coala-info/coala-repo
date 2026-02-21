cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy
label: hyphy-common_hyphy
doc: "HyPhy (Hypothesis Testing using Phylogenies) is a software package for the analysis
  of genetic sequences using techniques in phylogenetics, molecular evolution, and
  machine learning. (Note: The provided text is a container execution error log and
  does not contain usage instructions or argument definitions).\n\nTool homepage:
  http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-common:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-common_hyphy.out
