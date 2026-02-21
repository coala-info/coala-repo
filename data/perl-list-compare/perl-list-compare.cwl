cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-list-compare
label: perl-list-compare
doc: "The tool perl-list-compare was not found in the environment, and no help text
  was provided to parse.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-list-compare:0.53--pl5.22.0_0
stdout: perl-list-compare.out
