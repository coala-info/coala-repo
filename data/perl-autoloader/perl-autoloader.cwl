cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-autoloader
label: perl-autoloader
doc: "perl-autoloader (Note: The provided text contains execution logs and an error
  indicating the executable was not found, rather than help documentation. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/aur-archive/perl-autoloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-autoloader:5.74--pl5.22.0_0
stdout: perl-autoloader.out
