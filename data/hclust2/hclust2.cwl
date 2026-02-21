cwlVersion: v1.2
class: CommandLineTool
baseCommand: hclust2
label: hclust2
doc: "The provided text does not contain help information or argument definitions;
  it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://bitbucket.org/nsegata/hclust2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hclust2:1.0.0--pyh864c0ab_1
stdout: hclust2.out
