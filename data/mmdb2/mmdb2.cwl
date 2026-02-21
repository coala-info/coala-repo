cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmdb2
label: mmdb2
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the tool.\n\nTool homepage: https://www.ccp4.ac.uk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmdb2:2.0.22--h5ca1c30_2
stdout: mmdb2.out
