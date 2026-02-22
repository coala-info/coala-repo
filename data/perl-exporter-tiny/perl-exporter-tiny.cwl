cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-exporter-tiny
label: perl-exporter-tiny
doc: "Exporter::Tiny is a tiny Perl exporter with features similar to Sub::Exporter
  but with far fewer dependencies. Note: The provided text appears to be a container
  runtime error log rather than CLI help text, so no arguments could be extracted.\n\
  \nTool homepage: https://metacpan.org/release/Exporter-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-exporter-tiny:1.002002--pl5321hdfd78af_0
stdout: perl-exporter-tiny.out
