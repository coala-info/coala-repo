cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta36
label: fasta3_fasta36
doc: "The provided text does not contain help information for the tool, but rather
  an error message from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space. FASTA36 is a suite of programs for
  searching nucleotide or protein databases.\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_fasta36.out
