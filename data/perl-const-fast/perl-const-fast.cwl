cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-const-fast
label: perl-const-fast
doc: "The provided text does not contain help information for perl-const-fast; it
  is an error log indicating the executable was not found.\n\nTool homepage: http://metacpan.org/pod/Const-Fast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-const-fast:0.014--pl526_0
stdout: perl-const-fast.out
