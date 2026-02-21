cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-locale
label: perl-locale
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-locale:1.03--pl5.22.0_0
stdout: perl-locale.out
