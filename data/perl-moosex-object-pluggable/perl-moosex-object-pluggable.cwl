cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-object-pluggable
label: perl-moosex-object-pluggable
doc: "MooseX::Object::Pluggable is a Perl module that provides a role for Moose-based
  classes to easily load and manage plugins.\n\nTool homepage: https://github.com/moose/MooseX-Object-Pluggable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-object-pluggable:0.0014--pl526_0
stdout: perl-moosex-object-pluggable.out
