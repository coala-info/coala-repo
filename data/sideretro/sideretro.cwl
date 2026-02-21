cwlVersion: v1.2
class: CommandLineTool
baseCommand: sideretro
label: sideretro
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/galantelab/sideRETRO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
stdout: sideretro.out
