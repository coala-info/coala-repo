cwlVersion: v1.2
class: CommandLineTool
baseCommand: nemo
label: nemo
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion.\n\nTool homepage: http://nemo2.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nemo:2.3.51--h869255c_0
stdout: nemo.out
