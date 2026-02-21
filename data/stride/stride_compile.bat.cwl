cwlVersion: v1.2
class: CommandLineTool
baseCommand: stride_compile.bat
label: stride_compile.bat
doc: "A script for compiling or building the STRIDE tool container. Note: The provided
  text contains execution logs and error messages rather than standard help documentation.\n
  \nTool homepage: https://github.com/stride3d/stride"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stride:1.0--1
stdout: stride_compile.bat.out
