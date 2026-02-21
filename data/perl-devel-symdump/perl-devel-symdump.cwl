cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-symdump
label: perl-devel-symdump
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: https://github.com/gooselinux/perl-Devel-Symdump"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-symdump:2.18--pl5.22.0_0
stdout: perl-devel-symdump.out
