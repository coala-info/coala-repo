cwlVersion: v1.2
class: CommandLineTool
baseCommand: bicseq2-norm
label: bicseq2-norm
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container due to insufficient disk space.\n
  \nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-norm:0.2.4--h7b50bb2_6
stdout: bicseq2-norm.out
