cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-set-intspan
label: perl-set-intspan
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: https://github.com/pld-linux/perl-Set-IntSpan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-set-intspan:1.19--0
stdout: perl-set-intspan.out
