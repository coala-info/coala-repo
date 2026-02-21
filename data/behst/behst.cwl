cwlVersion: v1.2
class: CommandLineTool
baseCommand: behst
label: behst
doc: "BEHST (Binding Enrichment Heterogeneity Statistical Test) is a tool for identifying
  genomic regions with significant enrichment of chromatin interactions or transcription
  factor binding sites.\n\nTool homepage: https://bitbucket.org/hoffmanlab/behst/overview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/behst:3.8--0
stdout: behst.out
