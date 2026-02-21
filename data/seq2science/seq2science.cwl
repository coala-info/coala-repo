cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2science
label: seq2science
doc: "A workflow tool for sequencing data. (Note: The provided text is a system error
  log regarding a container build failure and does not contain CLI help documentation
  or argument definitions.)\n\nTool homepage: https://vanheeringen-lab.github.io/seq2science"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
stdout: seq2science.out
