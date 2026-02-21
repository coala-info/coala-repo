cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-filter-simple
label: perl-filter-simple
doc: "The tool 'perl-filter-simple' could not be executed because the executable was
  not found in the system PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-filter-simple:0.91--pl5.22.0_0
stdout: perl-filter-simple.out
