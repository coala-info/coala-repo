cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-buildindex
label: subread-data_subread-buildindex
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data_subread-buildindex.out
