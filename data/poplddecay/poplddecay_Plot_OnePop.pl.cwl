cwlVersion: v1.2
class: CommandLineTool
baseCommand: poplddecay_Plot_OnePop.pl
label: poplddecay_Plot_OnePop.pl
doc: "A tool for plotting Linkage Disequilibrium (LD) decay for a single population.
  Note: The provided help text contains container runtime errors and does not list
  specific arguments.\n\nTool homepage: https://github.com/BGI-shenzhen/PopLDdecay"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poplddecay:3.43--hdcf5f25_1
stdout: poplddecay_Plot_OnePop.pl.out
