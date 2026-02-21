cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgp-processcuration
label: vgp-processcuration
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a container build failure. No arguments could be extracted.\n
  \nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration.out
