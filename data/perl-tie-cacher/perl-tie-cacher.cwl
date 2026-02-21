cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-cacher
label: perl-tie-cacher
doc: "The provided text is an error log indicating that the executable 'perl-tie-cacher'
  was not found in the system path. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-cacher:0.09--pl526_3
stdout: perl-tie-cacher.out
