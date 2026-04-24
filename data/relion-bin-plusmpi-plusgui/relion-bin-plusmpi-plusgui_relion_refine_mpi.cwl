cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_refine_mpi
label: relion-bin-plusmpi-plusgui_relion_refine_mpi
doc: "RELION MPI setup\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: num_mpi_processes
    type:
      - 'null'
      - int
    doc: Number of MPI processes
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_refine_mpi.out
