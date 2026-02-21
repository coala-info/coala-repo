cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-hash
label: perl-tie-hash
doc: "The executable 'perl-tie-hash' was not found in the system path, and no help
  text was available to parse.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-hash:1.05--pl5.22.0_0
stdout: perl-tie-hash.out
