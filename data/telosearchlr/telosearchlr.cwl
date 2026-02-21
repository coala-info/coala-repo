cwlVersion: v1.2
class: CommandLineTool
baseCommand: telosearchlr
label: telosearchlr
doc: "A tool for searching telomeres in long-read sequencing data (Note: The provided
  text is a container build log and does not contain CLI help information).\n\nTool
  homepage: https://github.com/gchchung/TeloSearchLR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telosearchlr:1.0.1--pyhdfd78af_0
stdout: telosearchlr.out
