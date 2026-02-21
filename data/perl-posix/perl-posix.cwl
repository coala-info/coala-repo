cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-posix
label: perl-posix
doc: "The executable 'perl-posix' was not found in the system path, and no help text
  was provided to parse.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-posix:1.38_03--pl5.22.0_0
stdout: perl-posix.out
