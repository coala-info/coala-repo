cwlVersion: v1.2
class: CommandLineTool
baseCommand: idemuxcpp
label: idemuxcpp
doc: "A tool for demultiplexing sequencing data (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/Lexogen-Tools/idemuxcpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idemuxcpp:0.3.0--h077b44d_2
stdout: idemuxcpp.out
