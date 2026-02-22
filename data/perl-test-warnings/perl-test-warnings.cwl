cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-warnings
label: perl-test-warnings
doc: "A Perl module (Test::Warnings) used to test for warnings during code execution.
  Note: The provided text contains system error logs rather than CLI help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/karenetheridge/Test-Warnings"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-warnings:0.031--pl5321hdfd78af_0
stdout: perl-test-warnings.out
