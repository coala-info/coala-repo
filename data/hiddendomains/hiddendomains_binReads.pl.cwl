cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiddendomains_binReads.pl
label: hiddendomains_binReads.pl
doc: "A script from the hiddenDomains package for binning reads. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list usage or arguments).\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains_binReads.pl.out
