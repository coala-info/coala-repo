cwlVersion: v1.2
class: CommandLineTool
baseCommand: galitime
label: galitime
doc: "The provided help text contains only system error messages related to container
  image building and does not include usage information or a description of the tool's
  functionality.\n\nTool homepage: https://github.com/karel-brinda/galitime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galitime:0.2.0--pyhdfd78af_0
stdout: galitime.out
