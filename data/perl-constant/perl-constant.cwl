cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-constant
label: perl-constant
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs indicating that the executable 'perl-constant' was not
  found in the system path.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-constant:1.33--pl5.22.0_0
stdout: perl-constant.out
