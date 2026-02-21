cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsearch
label: hhsuite_hhsearch
doc: "HHsearch is a tool for sensitive protein sequence searching based on the pairwise
  alignment of hidden Markov models (HMMs). (Note: The provided help text contained
  only system error messages and no usage information.)\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_hhsearch.out
