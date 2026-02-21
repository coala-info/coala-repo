cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-par
label: perl-par
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a container build process that failed because the executable
  'perl-par' was not found.\n\nTool homepage: https://github.com/rschupp/PAR-Packer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par:1.014--pl5.22.0_0
stdout: perl-par.out
