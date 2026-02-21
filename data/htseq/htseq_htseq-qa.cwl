cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-qa
label: htseq_htseq-qa
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/htseq/htseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.0.9--py311h8fb3dee_0
stdout: htseq_htseq-qa.out
