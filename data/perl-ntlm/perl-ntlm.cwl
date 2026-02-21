cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ntlm
label: perl-ntlm
doc: "The provided text is an error log indicating that the executable 'perl-ntlm'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/stevenl/Authen-SASL-Perl-NTLM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ntlm:1.09--pl526_3
stdout: perl-ntlm.out
