cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpanm
label: perl-app-cpanminus
doc: "The provided text does not contain help information as it is an error log indicating
  that the executable was not found. perl-app-cpanminus (cpanm) is typically used
  to get, unpack, build and install modules from CPAN.\n\nTool homepage: https://github.com/miyagawa/cpanminus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-app-cpanminus:1.7044--pl526_1
stdout: perl-app-cpanminus.out
