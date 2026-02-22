cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-db-embl
label: perl-bio-db-embl
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a failed container execution (no space
  left on device).\n\nTool homepage: https://metacpan.org/release/Bio-DB-EMBL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-db-embl:1.7.4--pl5321hdfd78af_0
stdout: perl-bio-db-embl.out
