cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_refine_mpi
label: relion-bin-plusmpi_relion_refine_mpi
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi_relion_refine_mpi.out
