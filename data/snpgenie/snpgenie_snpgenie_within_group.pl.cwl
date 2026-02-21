cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_within_group.pl
label: snpgenie_snpgenie_within_group.pl
doc: "SNPGenie: Estimating evolutionary parameters from pooled next-generation sequencing
  (NGS) data within a single population or group.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie_within_group.pl.out
