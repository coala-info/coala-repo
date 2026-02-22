cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-config-tiny
label: perl-config-tiny
doc: "A Perl module to read and write .ini style configuration files with as little
  code as possible.\n\nTool homepage: http://metacpan.org/pod/Config::Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-config-tiny:2.28--pl5321hdfd78af_0
stdout: perl-config-tiny.out
