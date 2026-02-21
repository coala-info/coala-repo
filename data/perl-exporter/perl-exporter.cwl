cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-exporter
label: perl-exporter
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-exporter:5.72--pl5.22.0_0
stdout: perl-exporter.out
