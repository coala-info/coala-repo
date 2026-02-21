cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasty36
label: fasta3_fasty36
doc: "The provided text is a system error message regarding a container runtime failure
  (Apptainer/Singularity) and does not contain the help documentation or usage instructions
  for the tool.\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_fasty36.out
