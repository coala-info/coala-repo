cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-clone-pp
label: perl-clone-pp
doc: "Clone::PP is a Perl module that provides a general-purpose clone function to
  make deep copies of Perl data structures.\n\nTool homepage: http://metacpan.org/pod/Clone::PP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-clone-pp:1.08--pl5321hdfd78af_0
stdout: perl-clone-pp.out
