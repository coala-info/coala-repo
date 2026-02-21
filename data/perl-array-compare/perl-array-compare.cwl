cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-array-compare
label: perl-array-compare
doc: "The provided text is an error log indicating that the executable 'perl-array-compare'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: http://metacpan.org/pod/Array::Compare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-array-compare:3.0.1--pl526_0
stdout: perl-array-compare.out
