cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-vars
label: perl-vars
doc: "The tool 'perl-vars' could not be executed, and no help text was provided in
  the input. The provided text contains system logs indicating a failure to find the
  executable.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-vars:1.03--pl5.22.0_0
stdout: perl-vars.out
