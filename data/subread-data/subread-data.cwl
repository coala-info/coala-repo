cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-data
label: subread-data
doc: "The provided text is a container runtime error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data.out
