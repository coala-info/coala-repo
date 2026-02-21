cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounterToJson.pl
label: perl-sanger-cgp-allelecount_alleleCounterToJson.pl
doc: "A script to convert allele count results to JSON format. (Note: The provided
  text contains container build errors rather than help documentation; no arguments
  could be extracted.)\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
stdout: perl-sanger-cgp-allelecount_alleleCounterToJson.pl.out
