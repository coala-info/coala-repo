cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-eol
label: perl-test-eol
doc: "A tool to check for correct line endings in files.\n\nTool homepage: http://metacpan.org/release/Test-EOL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-eol:2.02--pl5321hdfd78af_0
stdout: perl-test-eol.out
