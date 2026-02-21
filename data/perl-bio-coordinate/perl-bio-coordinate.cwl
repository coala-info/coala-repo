cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-coordinate
label: perl-bio-coordinate
doc: "A tool from the BioPerl suite for coordinate transformations. (Note: The provided
  input text contained system error logs rather than help documentation; no arguments
  could be extracted.)\n\nTool homepage: https://metacpan.org/release/Bio-Coordinate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-coordinate:1.007001--pl526_0
stdout: perl-bio-coordinate.out
