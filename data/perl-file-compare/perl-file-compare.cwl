cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-compare
label: perl-file-compare
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-compare:1.1006--pl526_1
stdout: perl-file-compare.out
