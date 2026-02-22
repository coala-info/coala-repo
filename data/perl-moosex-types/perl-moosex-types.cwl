cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-types
label: perl-moosex-types
doc: "MooseX::Types is a Perl module that allows you to organize your Moose types
  in libraries. Note: The provided text contains system error messages regarding disk
  space and container conversion rather than functional help text.\n\nTool homepage:
  https://github.com/moose/MooseX-Types"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-types:0.51--pl5321hdfd78af_0
stdout: perl-moosex-types.out
