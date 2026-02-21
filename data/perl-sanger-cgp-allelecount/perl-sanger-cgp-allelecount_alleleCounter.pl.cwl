cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounter.pl
label: perl-sanger-cgp-allelecount_alleleCounter.pl
doc: "A tool from the Sanger CGP suite (perl-sanger-cgp-allelecount) used for counting
  alleles in genomic data. Note: The provided input text was an error log and did
  not contain help documentation for argument extraction.\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
stdout: perl-sanger-cgp-allelecount_alleleCounter.pl.out
