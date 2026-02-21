cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-types-stringlike
label: perl-moosex-types-stringlike
doc: "MooseX::Types::Stringlike - common Moose types for string-like objects. (Note:
  The provided text indicates a execution failure and does not contain usage instructions
  or arguments.)\n\nTool homepage: https://github.com/dagolden/MooseX-Types-Stringlike"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-types-stringlike:0.003--pl526_0
stdout: perl-moosex-types-stringlike.out
