cwlVersion: v1.2
class: CommandLineTool
baseCommand: lz4
label: lz4-bin
doc: "LZ4 is a lossless compression algorithm. (Note: The provided help text contains
  only container runtime error messages and no tool-specific usage information.)\n
  \nTool homepage: https://github.com/Gembal77/script-hack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lz4-bin:131--h7b50bb2_8
stdout: lz4-bin.out
