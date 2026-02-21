cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-color-theme
label: perl-color-theme
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log indicating that the executable was not found.\n
  \nTool homepage: https://metacpan.org/release/Color-Theme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-color-theme:0.10.1--pl526_0
stdout: perl-color-theme.out
