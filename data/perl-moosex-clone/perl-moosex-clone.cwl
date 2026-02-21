cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-clone
label: perl-moosex-clone
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container image build/fetch process due to insufficient disk space.\n
  \nTool homepage: https://github.com/moose/MooseX-Clone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-clone:0.06--0
stdout: perl-moosex-clone.out
