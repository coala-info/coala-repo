cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-encode-locale
label: perl-encode-locale
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a system error log indicating that the executable 'perl-encode-locale'
  was not found in the environment.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-encode-locale:1.05--pl5.22.0_0
stdout: perl-encode-locale.out
