cwlVersion: v1.2
class: CommandLineTool
baseCommand: orientagraph
label: orientagraph
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain the tool's help documentation
  or usage instructions.\n\nTool homepage: https://github.com/sriramlab/OrientAGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orientagraph:1.1--h3b735ea_0
stdout: orientagraph.out
