cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_rnaseq
label: sequana_sequana_rnaseq
doc: "The provided text is an error log regarding a container build failure (no space
  left on device) and does not contain the help text or argument definitions for the
  tool.\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequana_rnaseq.out
