cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqmetrics
label: fastqmetrics
doc: "A tool for calculating metrics from FASTQ files (Note: The provided input text
  contains container runtime error messages rather than the tool's help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/wdecoster/fastqmetrics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqmetrics:0.1.0--py35_0
stdout: fastqmetrics.out
