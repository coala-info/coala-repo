cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_ESPRESSO_S.pl
label: espresso_ESPRESSO_S.pl
doc: "ESPRESSO (Error-tolerant Shorthand Pipeline for Splice Isoform RNA-seq) S module.
  Note: The provided help text contains system error messages regarding container
  execution and does not list specific command-line arguments.\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_ESPRESSO_S.pl.out
