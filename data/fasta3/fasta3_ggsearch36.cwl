cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggsearch36
label: fasta3_ggsearch36
doc: "The provided text does not contain help information for the tool; it contains
  error messages related to a container runtime (Apptainer/Singularity) failure due
  to insufficient disk space.\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_ggsearch36.out
