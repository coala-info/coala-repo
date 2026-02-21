cwlVersion: v1.2
class: CommandLineTool
baseCommand: enrichm
label: enrichm
doc: "EnrichM is a toolbox for comparing the functional potential of microbial genomes
  and metagenomes. (Note: The provided text contains a system error log rather than
  help documentation; no arguments could be extracted.)\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
stdout: enrichm.out
