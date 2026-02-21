cwlVersion: v1.2
class: CommandLineTool
baseCommand: igblast
label: igblast
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: http://www.ncbi.nlm.nih.gov/projects/igblast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igblast:1.22.0--h6a68c12_1
stdout: igblast.out
