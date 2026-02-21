cwlVersion: v1.2
class: CommandLineTool
baseCommand: tfastx36
label: fasta3_tfastx36
doc: "The provided text is a system error log (Apptainer/Singularity failure) and
  does not contain the help documentation for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3_tfastx36.out
