cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonclust2
label: isonclust2
doc: "The provided text does not contain help information for isonclust2; it contains
  system error messages regarding a failed container build due to insufficient disk
  space.\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
stdout: isonclust2.out
