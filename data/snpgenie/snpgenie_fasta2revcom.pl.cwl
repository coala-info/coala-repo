cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_fasta2revcom.pl
label: snpgenie_fasta2revcom.pl
doc: "A script from the SNPGenie suite to convert FASTA sequences to their reverse
  complement. (Note: The provided help text contained only system error messages;
  no specific arguments could be parsed from the input.)\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_fasta2revcom.pl.out
