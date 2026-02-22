cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-padwalker
label: perl-padwalker
doc: "PadWalker is a Perl module that allows inspection and manipulation of lexical
  variables in any subroutine currently in the calling stack. Note: The provided text
  contains system error messages regarding disk space and does not contain CLI help
  documentation.\n\nTool homepage: http://metacpan.org/pod/PadWalker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-padwalker:2.5--pl5321h9948957_5
stdout: perl-padwalker.out
