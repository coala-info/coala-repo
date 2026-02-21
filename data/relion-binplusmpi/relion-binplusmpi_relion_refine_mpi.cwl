cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relion_refine_mpi
label: relion-binplusmpi_relion_refine_mpi
doc: "RELION (REgularised LIkelihood OptimisatioN) refinement tool (MPI version).
  Note: The provided text appears to be a container execution error log rather than
  help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_relion_refine_mpi.out
