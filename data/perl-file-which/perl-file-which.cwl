cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-which
label: perl-file-which
doc: "The provided text does not contain help information or a description for the
  tool, as it is an error log indicating the executable was not found.\n\nTool homepage:
  https://metacpan.org/pod/File::Which"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-which:1.23--pl526_0
stdout: perl-file-which.out
