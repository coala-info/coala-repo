cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-exporter-progressive
label: perl-sub-exporter-progressive
doc: "The provided text does not contain help information; it is an error log indicating
  that the executable 'perl-sub-exporter-progressive' was not found in the system
  PATH.\n\nTool homepage: http://search.cpan.org/dist/Sub-Exporter-Progressive/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-exporter-progressive:0.001013--pl526_0
stdout: perl-sub-exporter-progressive.out
