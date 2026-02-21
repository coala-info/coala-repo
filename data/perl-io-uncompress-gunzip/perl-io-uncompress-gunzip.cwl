cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-uncompress-gunzip
label: perl-io-uncompress-gunzip
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-uncompress-gunzip:2.064--pl5.22.0_0
stdout: perl-io-uncompress-gunzip.out
