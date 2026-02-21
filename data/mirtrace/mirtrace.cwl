cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirtrace
label: mirtrace
doc: "miRTrace is a quality control tool for small RNA sequencing data. (Note: The
  provided input text appears to be a container runtime error log rather than the
  tool's help output, so no arguments could be extracted.)\n\nTool homepage: https://github.com/friedlanderlab/mirtrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirtrace:1.0.1--0
stdout: mirtrace.out
