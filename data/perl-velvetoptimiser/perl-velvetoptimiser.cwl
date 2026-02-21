cwlVersion: v1.2
class: CommandLineTool
baseCommand: VelvetOptimiser.pl
label: perl-velvetoptimiser
doc: "VelvetOptimiser is a script to automatically optimize the three primary parameter
  settings for the Velvet de novo assembler.\n\nTool homepage: https://github.com/tseemann/VelvetOptimiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-velvetoptimiser:2.2.6--pl526_0
stdout: perl-velvetoptimiser.out
