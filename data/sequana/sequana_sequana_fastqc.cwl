cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_fastqc
label: sequana_sequana_fastqc
doc: "A tool from the Sequana framework. Note: The provided input text appears to
  be a system error log regarding a failed container build (no space left on device)
  rather than the command-line help text. Consequently, no arguments could be extracted.\n
  \nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequana_fastqc.out
