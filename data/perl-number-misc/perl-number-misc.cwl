cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-number-misc
label: perl-number-misc
doc: "A tool for miscellaneous number-related operations in Perl.\n\nTool homepage:
  http://metacpan.org/pod/Number::Misc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-number-misc:1.2--pl526_1
stdout: perl-number-misc.out
