cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_fastadigeststats
label: pythomics_fastadigeststats
doc: "A tool from the pythomics package for calculating statistics on digested FASTA
  sequences. (Note: The provided help text contains only container execution errors
  and no usage information.)\n\nTool homepage: https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_fastadigeststats.out
