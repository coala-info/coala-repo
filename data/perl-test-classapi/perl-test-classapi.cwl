cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-classapi
label: perl-test-classapi
doc: "A tool for testing Class::API in Perl. (Note: The provided text contains execution
  errors and does not list specific help documentation or arguments.)\n\nTool homepage:
  https://github.com/karenetheridge/Test-ClassAPI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-classapi:1.07--pl526_0
stdout: perl-test-classapi.out
