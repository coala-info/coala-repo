cwlVersion: v1.2
class: CommandLineTool
baseCommand: yanagiba
label: yanagiba
doc: "A tool for processing and filtering Oxford Nanopore sequencing data. (Note:
  The provided text contained container build logs rather than the tool's help output;
  no arguments could be extracted from the source text.)\n\nTool homepage: https://github.com/Adamtaranto/Yanagiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yanagiba:1.0.0--py36_1
stdout: yanagiba.out
