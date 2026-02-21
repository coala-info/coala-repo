cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nemo
  - nemosub
label: nemo_nemosub
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system error logs related to a container runtime
  failure.\n\nTool homepage: http://nemo2.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nemo:2.3.51--h869255c_0
stdout: nemo_nemosub.out
