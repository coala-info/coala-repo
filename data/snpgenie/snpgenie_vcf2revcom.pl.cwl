cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_vcf2revcom.pl
label: snpgenie_vcf2revcom.pl
doc: "A script from the SNPGenie software suite. (Note: The provided text contains
  container environment logs and a fatal error message rather than the tool's help
  documentation, so no arguments could be extracted.)\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_vcf2revcom.pl.out
