cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_refine_mpi
label: relion-bin-plusmpi-plusgui_relion_refine_mpi
doc: "Relion Refine MPI (Note: The provided input text contains container execution
  errors rather than tool help text, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusmpi-plusgui_relion_refine_mpi.out
