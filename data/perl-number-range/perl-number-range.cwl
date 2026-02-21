cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-number-range
label: perl-number-range
doc: "The provided text is an error log indicating that the executable 'perl-number-range'
  was not found in the system PATH; therefore, no usage information or arguments could
  be extracted.\n\nTool homepage: http://metacpan.org/pod/Number::Range"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-number-range:0.12--pl526_0
stdout: perl-number-range.out
