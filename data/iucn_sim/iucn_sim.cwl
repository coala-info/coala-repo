cwlVersion: v1.2
class: CommandLineTool
baseCommand: iucn_sim
label: iucn_sim
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failure due to
  insufficient disk space.\n\nTool homepage: https://github.com/tobiashofmann88/iucn_extinction_simulator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
stdout: iucn_sim.out
