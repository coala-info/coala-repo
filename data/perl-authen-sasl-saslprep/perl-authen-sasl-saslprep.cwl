cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-authen-sasl-saslprep
label: perl-authen-sasl-saslprep
doc: "The provided text does not contain help information or a description for the
  tool, as it is an error log indicating that the executable was not found in the
  PATH.\n\nTool homepage: http://metacpan.org/pod/Authen-SASL-SASLprep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-authen-sasl-saslprep:1.100--pl526_0
stdout: perl-authen-sasl-saslprep.out
