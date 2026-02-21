cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj
label: spp-dcj
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log. No arguments could be extracted.\n\nTool homepage: https://github.com/codialab/spp-dcj"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj.out
