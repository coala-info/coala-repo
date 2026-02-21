cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiddendomains_domainsToBed.pl
label: hiddendomains_domainsToBed.pl
doc: "A script to convert hidden domains output to BED format.\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains_domainsToBed.pl.out
