cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xsloader
label: perl-xsloader
doc: "The provided text does not contain help information for perl-xsloader. It is
  an error log indicating that the executable was not found in the environment.\n\n
  Tool homepage: https://metacpan.org/module/XSLoader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xsloader:0.24--pl526_0
stdout: perl-xsloader.out
