cwlVersion: v1.2
class: CommandLineTool
baseCommand: paste-bio
label: paste-bio
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it consists of system error messages regarding disk space
  and container image conversion.\n\nTool homepage: https://github.com/raphael-group/paste"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paste-bio:1.4.0--pyh7cba7a3_0
stdout: paste-bio.out
