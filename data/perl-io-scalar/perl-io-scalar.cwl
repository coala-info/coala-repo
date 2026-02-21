cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-scalar
label: perl-io-scalar
doc: The provided text is an error log indicating that the executable 'perl-io-scalar'
  was not found in the system PATH. No help text or usage information was available
  to extract arguments.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-scalar:2.111--pl526_1
stdout: perl-io-scalar.out
