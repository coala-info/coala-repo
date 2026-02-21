cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-blib
label: perl-blib
doc: The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-blib:1.06--pl5.22.0_0
stdout: perl-blib.out
