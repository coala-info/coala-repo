cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-exporter-tidy
label: perl-exporter-tidy
doc: "The perl-exporter-tidy tool (Note: The provided text contains execution logs
  and an error indicating the executable was not found, rather than help documentation.
  No arguments could be extracted.)\n\nTool homepage: https://github.com/Juerd/Exporter-Tidy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-exporter-tidy:0.08--pl526_1
stdout: perl-exporter-tidy.out
