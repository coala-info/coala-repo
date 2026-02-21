cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-gff3
label: perl-bio-gff3
doc: The provided text does not contain help information or a description for the
  tool. It appears to be an error log indicating that the executable was not found
  in the environment.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-gff3:2.0--pl526_1
stdout: perl-bio-gff3.out
