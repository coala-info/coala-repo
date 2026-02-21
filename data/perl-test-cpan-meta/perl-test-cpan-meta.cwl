cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-cpan-meta
label: perl-test-cpan-meta
doc: "A tool to validate CPAN META.yml files. (Note: The provided text contains error
  logs indicating the executable was not found, rather than standard help text documentation.)\n
  \nTool homepage: https://github.com/gooselinux/perl-Test-CPAN-Meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-cpan-meta:0.25--pl526_1
stdout: perl-test-cpan-meta.out
