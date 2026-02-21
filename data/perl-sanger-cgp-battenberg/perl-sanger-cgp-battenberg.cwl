cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sanger-cgp-battenberg
label: perl-sanger-cgp-battenberg
doc: 'Battenberg algorithm to detect allele-specific copy number changes from whole
  genome sequencing data. (Note: The provided text is a container execution error
  log and does not contain specific CLI argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-battenberg:1.4.1--3
stdout: perl-sanger-cgp-battenberg.out
