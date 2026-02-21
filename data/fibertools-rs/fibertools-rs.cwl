cwlVersion: v1.2
class: CommandLineTool
baseCommand: fibertools-rs
label: fibertools-rs
doc: "A tool for analyzing fiber-seq data (Note: The provided help text contains only
  container runtime error messages and no CLI usage information).\n\nTool homepage:
  https://github.com/mrvollger/fibertools-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.1--h3b373d1_0
stdout: fibertools-rs.out
