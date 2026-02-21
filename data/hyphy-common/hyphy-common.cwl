cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy-common
label: hyphy-common
doc: "HyPhy (Hypothesis Testing using Phylogenies) common utilities. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-common:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-common.out
