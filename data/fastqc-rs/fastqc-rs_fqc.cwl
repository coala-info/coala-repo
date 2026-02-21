cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqc
label: fastqc-rs_fqc
doc: "A fast and multi-threaded QC tool for FASTQ files (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/fxwiegand/fastqc-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqc-rs:0.3.4--h101ab07_0
stdout: fastqc-rs_fqc.out
