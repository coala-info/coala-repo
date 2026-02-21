cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-simple-text
label: perl-pod-simple-text
doc: 'Convert POD (Plain Old Documentation) data to formatted ASCII text. Note: The
  provided input text was an error log indicating the executable was not found, so
  no specific arguments could be parsed from it.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-simple-text:3.28--pl526_1
stdout: perl-pod-simple-text.out
