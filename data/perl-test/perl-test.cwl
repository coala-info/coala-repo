cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test
label: perl-test
doc: "The tool 'perl-test' was not found in the system path, and no help text was
  provided to describe its functionality.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test:1.26--pl5.22.0_0
stdout: perl-test.out
