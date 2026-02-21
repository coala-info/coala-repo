cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-util-properties
label: perl-util-properties
doc: "The provided text does not contain help information or usage instructions for
  perl-util-properties; it is a log of a failed container build process.\n\nTool homepage:
  http://metacpan.org/pod/Util::Properties"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-util-properties:0.18--0
stdout: perl-util-properties.out
