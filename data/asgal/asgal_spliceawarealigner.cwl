cwlVersion: v1.2
class: CommandLineTool
baseCommand: asgal
label: asgal_spliceawarealigner
doc: "ASGAL (Alternative Splicing Graph Aligner). Note: The provided input text contains
  system error messages regarding a container build failure ('no space left on device')
  and does not contain the actual help text or usage instructions for the tool.\n\n
  Tool homepage: https://asgal.algolab.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2
stdout: asgal_spliceawarealigner.out
