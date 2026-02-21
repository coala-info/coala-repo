cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-share
label: perl-file-share
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  https://github.com/ingydotnet/file-share-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-share:0.25--pl526_1
stdout: perl-file-share.out
