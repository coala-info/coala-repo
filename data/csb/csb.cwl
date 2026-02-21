cwlVersion: v1.2
class: CommandLineTool
baseCommand: csb
label: csb
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: http://github.com/csb-toolbox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csb:1.2.5--pyh24bf2e0_2
stdout: csb.out
