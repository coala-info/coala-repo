cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoBatch
label: crispresso2_CRISPRessoBatch
doc: "The provided text is an error log indicating a failure to build or fetch the
  container image ('no space left on device') and does not contain the help text or
  usage information for CRISPRessoBatch. As a result, no arguments could be extracted.\n\
  \nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: crispresso2_CRISPRessoBatch.out
