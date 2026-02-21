cwlVersion: v1.2
class: CommandLineTool
baseCommand: psmc_splitfa
label: psmc_splitfa
doc: "The provided text does not contain help information for psmc_splitfa; it appears
  to be a container execution error log.\n\nTool homepage: https://github.com/lh3/psmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: psmc_splitfa.out
