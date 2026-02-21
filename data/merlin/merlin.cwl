cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) and does not contain the help documentation for the tool
  'merlin'. As a result, no arguments could be extracted.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin.out
