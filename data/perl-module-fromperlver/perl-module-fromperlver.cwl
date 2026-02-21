cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-fromperlver
label: perl-module-fromperlver
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log file indicating a fatal error where the executable was not
  found in the system PATH.\n\nTool homepage: http://metacpan.org/pod/Module::FromPerlVer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-fromperlver:0.008002--0
stdout: perl-module-fromperlver.out
