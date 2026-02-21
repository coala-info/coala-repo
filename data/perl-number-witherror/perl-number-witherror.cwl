cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-number-witherror
label: perl-number-witherror
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments or descriptions could be parsed from the
  error log.\n\nTool homepage: http://metacpan.org/pod/Number::WithError"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-number-witherror:1.01--pl526_0
stdout: perl-number-witherror.out
