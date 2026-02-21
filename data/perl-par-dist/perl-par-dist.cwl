cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-par-dist
label: perl-par-dist
doc: "The provided text does not contain help information for the tool. It appears
  to be a system log indicating that the executable 'perl-par-dist' was not found
  in the environment.\n\nTool homepage: https://github.com/DrHyde/perl-modules-CPAN-ParseDistribution"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par-dist:0.49--pl5.22.0_0
stdout: perl-par-dist.out
