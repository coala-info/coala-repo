cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin
label: ribotin
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a failed container build/fetch process.\n
  \nTool homepage: https://github.com/maickrau/ribotin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotin:1.5--h077b44d_0
stdout: ribotin.out
