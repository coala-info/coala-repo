cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cpan-meta-validator
label: perl-cpan-meta-validator
doc: A tool to validate CPAN Meta files (META.json or META.yml) against the CPAN Meta
  Spec.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-meta-validator:2.140640--pl5.22.0_0
stdout: perl-cpan-meta-validator.out
