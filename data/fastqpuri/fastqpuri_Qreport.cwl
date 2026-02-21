cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri_Qreport
label: fastqpuri_Qreport
doc: "A tool for generating quality reports for FASTQ files, part of the FastqPuri
  suite. Note: The provided help text contains only container runtime error messages
  and does not list specific arguments.\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri_Qreport.out
