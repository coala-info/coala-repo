cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwread
label: bwread
doc: "A tool for reading BigWig files. (Note: The provided text contains system error
  messages regarding disk space and container pulling rather than the tool's help
  documentation.)\n\nTool homepage: http://github.com/endrebak/bwread"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwread:0.0.5--py311haab0aaa_3
stdout: bwread.out
