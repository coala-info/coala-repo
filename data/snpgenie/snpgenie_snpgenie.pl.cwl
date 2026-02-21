cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie.pl
label: snpgenie_snpgenie.pl
doc: "SNPGenie is a tool for estimating evolutionary parameters from next-generation
  sequencing data. (Note: The provided text contains container runtime error logs
  rather than help documentation; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie.pl.out
