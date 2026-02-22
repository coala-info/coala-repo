cwlVersion: v1.2
class: CommandLineTool
baseCommand: scispacy
label: scispacy
doc: "A Python library for biomedical natural language processing. (Note: The provided
  text is a system error log regarding container image pulling and does not contain
  CLI help documentation or argument definitions.)\n\nTool homepage: https://allenai.github.io/scispacy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scispacy:0.6.2--pyhdfd78af_1
stdout: scispacy.out
