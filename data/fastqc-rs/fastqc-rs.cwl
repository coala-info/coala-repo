cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqc-rs
label: fastqc-rs
doc: "A tool for quality control of high-throughput sequencing data (Rust implementation).
  Note: The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/fxwiegand/fastqc-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqc-rs:0.3.4--h101ab07_0
stdout: fastqc-rs.out
