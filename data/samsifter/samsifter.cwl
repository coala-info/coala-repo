cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsifter
label: samsifter
doc: 'A tool for sifting SAM/BAM files (Note: The provided text contains system error
  logs rather than help documentation; no arguments could be extracted).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter.out
