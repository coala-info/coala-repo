cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-types-path-class
label: perl-moosex-types-path-class
doc: "MooseX::Types::Path::Class - A Path::Class type library for Moose\n\nTool homepage:
  https://github.com/pld-linux/perl-MooseX-Types-Path-Class"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-types-path-class:0.09--0
stdout: perl-moosex-types-path-class.out
