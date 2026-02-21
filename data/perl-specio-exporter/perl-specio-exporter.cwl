cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-specio-exporter
label: perl-specio-exporter
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container due to insufficient disk space
  ('no space left on device').\n\nTool homepage: https://github.com/solus-packages/perl-specio-exporter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-specio-exporter:0.36--pl526_1
stdout: perl-specio-exporter.out
