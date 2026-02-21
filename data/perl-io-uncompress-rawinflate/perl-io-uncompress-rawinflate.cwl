cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-uncompress-rawinflate
label: perl-io-uncompress-rawinflate
doc: The provided text does not contain help information or a description for the
  tool; it is a log showing a fatal error where the executable was not found in the
  environment.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-uncompress-rawinflate:2.064--pl526_1
stdout: perl-io-uncompress-rawinflate.out
