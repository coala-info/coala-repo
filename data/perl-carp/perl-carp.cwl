cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-carp
label: perl-carp
doc: "The perl-carp executable was not found in the environment, and no help text
  was provided. Carp is typically a Perl module used for generating error messages.\n
  \nTool homepage: https://github.com/alabamenhu/Carp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-carp:1.38--pl526_1
stdout: perl-carp.out
