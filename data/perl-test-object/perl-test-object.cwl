cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-object
label: perl-test-object
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error indicating that the executable 'perl-test-object'
  was not found in the environment.\n\nTool homepage: https://github.com/karenetheridge/Test-Object"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-object:0.08--0
stdout: perl-test-object.out
