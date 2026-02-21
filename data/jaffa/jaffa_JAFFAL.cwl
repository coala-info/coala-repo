cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaffa_JAFFAL
label: jaffa_JAFFAL
doc: "JAFFA is a bioinformatic pipeline for finding transcript fusions. The JAFFAL
  version is specifically designed for long-read transcriptomics data or assembled
  contigs.\n\nTool homepage: https://github.com/Oshlack/JAFFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaffa:2.3--hdfd78af_0
stdout: jaffa_JAFFAL.out
