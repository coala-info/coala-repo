cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-list-someutils
label: perl-list-someutils
doc: "A Perl module providing various list utility functions. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific CLI arguments.)\n\nTool homepage: http://metacpan.org/release/List-SomeUtils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-list-someutils:0.59--pl5321h9948957_3
stdout: perl-list-someutils.out
