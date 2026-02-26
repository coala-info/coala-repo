cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin-plusmpi_relion_refine_mpi
label: relion-bin-plusmpi_relion_refine_mpi
doc: "RELION MPI setup\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: master_host
    type:
      - 'null'
      - string
    doc: Master (0) runs on host
    inputBinding:
      position: 101
  - id: num_mpi_processes
    type:
      - 'null'
      - int
    doc: Number of MPI processes
    default: 1
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi_relion_refine_mpi.out
