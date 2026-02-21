cwlVersion: v1.2
class: CommandLineTool
baseCommand: HYPHYMPI
label: hyphy-common_HYPHYMPI
doc: "HyPhy (Hypothesis Testing using Phylogenies) is a software package for the analysis
  of genetic sequences using techniques in molecular evolution, phylogenetics, and
  machine learning. (Note: The provided help text contains only container runtime
  error messages and no argument definitions).\n\nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-common:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-common_HYPHYMPI.out
