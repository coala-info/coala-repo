cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-role-tiny-with
label: perl-role-tiny-with
doc: The provided text does not contain help information as the executable was not
  found in the environment.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-role-tiny-with:2.000005--pl5.22.0_0
stdout: perl-role-tiny-with.out
