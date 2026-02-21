cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test2
label: perl-test2
doc: "The tool 'perl-test2' could not be executed, and no help text was provided in
  the input. The provided text contains system logs indicating the executable was
  not found in the PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test2:1.302075--pl526_1
stdout: perl-test2.out
