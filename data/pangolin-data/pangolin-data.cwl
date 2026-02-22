cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangolin-data
label: pangolin-data
doc: "A tool for managing data updates for pangolin. (Note: The provided text contains
  system error messages regarding disk space and container extraction rather than
  the tool's help documentation.)\n\nTool homepage: https://github.com/cov-lineages/pangolin-data"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangolin-data:1.37--pyh7e72e81_0
stdout: pangolin-data.out
