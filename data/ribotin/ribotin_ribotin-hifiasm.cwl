cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotin-hifiasm
label: ribotin_ribotin-hifiasm
doc: "The provided text is a container runtime error log and does not contain help
  or usage information for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/maickrau/ribotin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotin:1.5--h077b44d_0
stdout: ribotin_ribotin-hifiasm.out
