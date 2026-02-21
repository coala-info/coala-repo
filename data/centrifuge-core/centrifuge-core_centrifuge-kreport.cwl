cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-kreport
label: centrifuge-core_centrifuge-kreport
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device) and does not contain help information or argument definitions.\n
  \nTool homepage: https://github.com/infphilo/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-kreport.out
