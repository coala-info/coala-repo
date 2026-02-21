cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-time-piece
label: perl-time-piece
doc: "The tool 'perl-time-piece' could not be executed, and no help text was provided
  in the input. The provided text indicates a fatal error where the executable was
  not found in the system PATH.\n\nTool homepage: https://github.com/barefootcoder/date-easy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-time-piece:1.27--pl5.22.0_0
stdout: perl-time-piece.out
