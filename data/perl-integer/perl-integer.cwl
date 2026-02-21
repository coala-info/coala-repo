cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-integer
label: perl-integer
doc: "The requested executable 'perl-integer' was not found in the system path. No
  help text or usage information is available from the provided output.\n\nTool homepage:
  https://github.com/jerry2yu/ngrams"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-integer:1.01--pl526_1
stdout: perl-integer.out
