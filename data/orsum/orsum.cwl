cwlVersion: v1.2
class: CommandLineTool
baseCommand: orsum
label: orsum
doc: "orsum (Filtering and Clustering of Enriched Terms) - Note: The provided text
  is an error log and does not contain help information or argument definitions.\n
  \nTool homepage: https://github.com/ozanozisik/orsum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orsum:1.8.0--hdfd78af_0
stdout: orsum.out
