cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_between_group.pl
label: snpgenie_snpgenie_between_group.pl
doc: "SNPGenie between-group analysis tool. (Note: The provided help text contains
  only container runtime logs and no usage information.)\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie_between_group.pl.out
