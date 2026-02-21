cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-data-inheritable
label: perl-class-data-inheritable
doc: "Class::Data::Inheritable is a Perl module that allows you to create accessor
  methods for class-specific data. This data can be inherited and then overridden
  by children.\n\nTool homepage: http://metacpan.org/pod/Class-Data-Inheritable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-data-inheritable:0.09--pl5321hdfd78af_0
stdout: perl-class-data-inheritable.out
