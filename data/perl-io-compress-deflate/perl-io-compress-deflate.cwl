cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-compress-deflate
label: perl-io-compress-deflate
doc: "Perl interface to allow reading and writing of RFC 1951 compliant deflate data.
  (Note: The provided help text indicates the executable was not found, so no specific
  arguments could be parsed from the output.)\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-compress-deflate:2.064--pl5.22.0_0
stdout: perl-io-compress-deflate.out
