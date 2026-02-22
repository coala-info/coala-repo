cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-attribute
label: perl-sub-attribute
doc: "The provided text does not contain help information or a description of the
  tool; it consists of system error messages related to a failed container build (no
  space left on device).\n\nTool homepage: http://metacpan.org/pod/Sub::Attribute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-attribute:0.07--pl5321h7b50bb2_2
stdout: perl-sub-attribute.out
