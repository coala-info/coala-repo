cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota-js-voroif-gnn
label: voronota_voronota-js-voroif-gnn
doc: "The provided text contains container runtime logs and does not include the help
  documentation or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://www.voronota.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_voronota-js-voroif-gnn.out
