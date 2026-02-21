cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-uncompress-bunzip2
label: perl-io-uncompress-bunzip2
doc: "A Perl-based utility for decompressing bunzip2 files. (Note: The provided help
  text indicates a fatal error where the executable was not found, so no specific
  arguments could be parsed from the input.)\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-uncompress-bunzip2:2.064--pl5.22.0_0
stdout: perl-io-uncompress-bunzip2.out
