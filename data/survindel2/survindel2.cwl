cwlVersion: v1.2
class: CommandLineTool
baseCommand: survindel2
label: survindel2
doc: "The provided text does not contain help information for survindel2; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch the tool's image.\n\nTool homepage: https://github.com/kensung-lab/SurVIndel2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
stdout: survindel2.out
