cwlVersion: v1.2
class: CommandLineTool
baseCommand: readCounter
label: hmmcopy_readCounter
doc: "Generates read counts for genomic bins. (Note: The provided input text contains
  container execution errors and does not list command-line arguments.)\n\nTool homepage:
  http://compbio.bccrc.ca/software/hmmcopy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_readCounter.out
