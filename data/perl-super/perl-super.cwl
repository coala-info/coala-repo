cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-super
label: perl-super
doc: "The provided text does not contain help information for perl-super; it is an
  error log indicating the executable was not found.\n\nTool homepage: http://metacpan.org/pod/SUPER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-super:1.20190531--pl526_0
stdout: perl-super.out
