cwlVersion: v1.2
class: CommandLineTool
baseCommand: pretextgraph
label: pretextgraph
doc: "A tool for generating Pretext contact maps (description not available in provided
  text)\n\nTool homepage: https://github.com/wtsi-hpag/PretextGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pretextgraph:0.0.9--h9948957_1
stdout: pretextgraph.out
