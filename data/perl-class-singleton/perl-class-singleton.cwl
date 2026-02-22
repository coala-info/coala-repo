cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-singleton
label: perl-class-singleton
doc: "Class::Singleton - A Perl module that implements a Singleton class (Note: The
  provided text is an error log and does not contain CLI help information).\n\nTool
  homepage: http://metacpan.org/pod/Class::Singleton"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-singleton:1.6--pl5321hdfd78af_0
stdout: perl-class-singleton.out
