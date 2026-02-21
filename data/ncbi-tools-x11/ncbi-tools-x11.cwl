cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-tools-x11
label: ncbi-tools-x11
doc: 'NCBI Tools with X11 graphical support. (Note: The provided text is a container
  runtime error log and does not contain usage instructions or argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-tools-x11:v6.1.20170106-6-deb_cv1
stdout: ncbi-tools-x11.out
