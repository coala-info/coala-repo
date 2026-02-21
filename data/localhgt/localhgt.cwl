cwlVersion: v1.2
class: CommandLineTool
baseCommand: localhgt
label: localhgt
doc: "A tool for horizontal gene transfer detection (Note: The provided text contains
  system logs and error messages rather than help documentation; no arguments could
  be extracted).\n\nTool homepage: https://github.com/samtools/samtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/localhgt:1.0.1--h9948957_3
stdout: localhgt.out
