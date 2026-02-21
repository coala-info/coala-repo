cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumiprocessor
label: illumiprocessor
doc: "A tool for processing Illumina sequencing data (Note: The provided text contains
  system error messages rather than help documentation, so specific arguments could
  not be extracted).\n\nTool homepage: https://github.com/faircloth-lab/illumiprocessor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumiprocessor:2.10--py_0
stdout: illumiprocessor.out
