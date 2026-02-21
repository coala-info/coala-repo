cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-env-path
label: perl-env-path
doc: "The provided text does not contain help documentation for the tool. It consists
  of system logs and a fatal error indicating that the executable 'perl-env-path'
  was not found in the system PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-env-path:0.19--pl526_2
stdout: perl-env-path.out
