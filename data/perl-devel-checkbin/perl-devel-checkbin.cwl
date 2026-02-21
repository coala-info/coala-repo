cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-checkbin
label: perl-devel-checkbin
doc: "A tool to check for the presence of binaries in the system PATH (Note: The provided
  help text contains only system logs and an error indicating the executable was not
  found).\n\nTool homepage: https://github.com/clearlinux-pkgs/perl-Devel-CheckBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-checkbin:0.04--pl526_1
stdout: perl-devel-checkbin.out
