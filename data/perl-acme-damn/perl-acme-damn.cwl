cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-acme-damn
label: perl-acme-damn
doc: "The provided text contains system error messages related to a Singularity/Docker
  container pull failure ('no space left on device') and does not contain help text
  or usage instructions for the tool. As a result, no arguments could be extracted.\n\
  \nTool homepage: http://metacpan.org/pod/Acme::Damn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-acme-damn:0.08--pl5321h9948957_9
stdout: perl-acme-damn.out
