cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhblits
label: hhsuite-data_hhblits
doc: "HHblits: lightning-fast iterative protein sequence searching by HMM-HMM alignment
  (Note: The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hhsuite-data:v3.0beta2dfsg-3-deb_cv1
stdout: hhsuite-data_hhblits.out
