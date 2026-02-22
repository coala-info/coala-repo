cwlVersion: v1.2
class: CommandLineTool
baseCommand: VelvetOptimiser.pl
label: velvetoptimiser
doc: "VelvetOptimiser is a script to help automate the optimization of the Velvet
  de novo assembler.\n\nTool homepage: https://github.com/tseemann/VelvetOptimiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/velvetoptimiser:v2.2.6-2-deb_cv1
stdout: velvetoptimiser.out
