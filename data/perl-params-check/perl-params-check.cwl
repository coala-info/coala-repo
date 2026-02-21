cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-params-check
label: perl-params-check
doc: "The provided text does not contain help information as the executable was not
  found in the environment. perl-params-check is likely a Perl-related utility or
  module wrapper.\n\nTool homepage: https://github.com/pld-linux/perl-Params-Check"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-params-check:0.38--pl5.22.0_0
stdout: perl-params-check.out
