cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-align
label: subread-data_subread-align
doc: "The provided text contains container runtime error messages and does not include
  the help documentation or usage instructions for the tool.\n\nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/subread-data:v1.6.3dfsg-1-deb_cv1
stdout: subread-data_subread-align.out
