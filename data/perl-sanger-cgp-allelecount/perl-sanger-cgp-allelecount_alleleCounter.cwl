cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounter
label: perl-sanger-cgp-allelecount_alleleCounter
doc: "A tool for counting alleles at specific genomic locations. Note: The provided
  help text contains system error messages regarding a failed container build and
  does not list command-line arguments.\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
stdout: perl-sanger-cgp-allelecount_alleleCounter.out
