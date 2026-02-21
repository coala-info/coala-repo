cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy-pt
label: hyphy-pt
doc: "HyPhy (Hypothesis testing using Phylogenies) - Protein/Partitioned analysis
  tool. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-pt:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-pt.out
