cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-longstring
label: perl-test-longstring
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  https://github.com/pld-linux/perl-Test-LongString"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-longstring:0.17--pl526_1
stdout: perl-test-longstring.out
