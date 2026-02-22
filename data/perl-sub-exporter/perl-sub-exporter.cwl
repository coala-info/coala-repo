cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-exporter
label: perl-sub-exporter
doc: "The provided text is an error log from a container execution environment and
  does not contain help documentation or usage instructions for the tool. Sub::Exporter
  is a Perl module used for exporting routines.\n\nTool homepage: https://github.com/rjbs/Sub-Exporter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-exporter:0.988--pl5321hdfd78af_0
stdout: perl-sub-exporter.out
