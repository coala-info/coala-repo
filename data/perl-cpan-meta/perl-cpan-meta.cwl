cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cpan-meta
label: perl-cpan-meta
doc: "A tool for processing CPAN Meta files (Note: The provided text indicates the
  executable was not found and does not contain help documentation).\n\nTool homepage:
  https://github.com/dagolden/cpan-meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-meta:2.150010--pl526_0
stdout: perl-cpan-meta.out
