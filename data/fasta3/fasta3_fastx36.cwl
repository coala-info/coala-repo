cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta36
label: fasta3_fastx36
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage information for the fasta3_fastx36
  tool. As a result, no arguments could be extracted.\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_fastx36.out
