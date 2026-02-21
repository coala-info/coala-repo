cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiddendomains_domainsMergeToBed.pl
label: hiddendomains_domainsMergeToBed.pl
doc: "A script from the hiddenDomains package to merge domain results into BED format.
  (Note: The provided input text contained system error messages rather than usage
  instructions, so no arguments could be extracted).\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains_domainsMergeToBed.pl.out
