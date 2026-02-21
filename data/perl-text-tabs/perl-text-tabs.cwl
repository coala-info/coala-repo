cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-tabs
label: perl-text-tabs
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-tabs:2013.0523--pl5.22.0_0
stdout: perl-text-tabs.out
