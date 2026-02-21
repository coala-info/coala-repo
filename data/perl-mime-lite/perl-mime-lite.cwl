cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mime-lite
label: perl-mime-lite
doc: "MIME::Lite is a Perl module for generating and sending MIME messages. (Note:
  The provided help text indicates a fatal error where the executable was not found
  in the environment, so no specific arguments could be parsed.)\n\nTool homepage:
  https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mime-lite:3.030--pl526_1
stdout: perl-mime-lite.out
