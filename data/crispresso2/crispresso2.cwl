cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPResso
label: crispresso2
doc: "CRISPResso2 is a software pipeline for the analysis of genome editing outcomes
  from deep sequencing data.\n\nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: crispresso2.out
