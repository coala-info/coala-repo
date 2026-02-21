cwlVersion: v1.2
class: CommandLineTool
baseCommand: resfinder
label: resfinder
doc: "ResFinder identifies acquired antimicrobial resistance genes in total or partial
  sequenced isolates of bacteria. (Note: The provided input text was a container engine
  error log and did not contain specific help documentation or argument definitions.)\n
  \nTool homepage: https://bitbucket.org/genomicepidemiology/resfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resfinder:4.7.2--pyhdfd78af_0
stdout: resfinder.out
