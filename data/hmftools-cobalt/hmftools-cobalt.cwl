cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobalt
label: hmftools-cobalt
doc: "COBALT (COunt B-ALlele Target) is a tool used to determine read ratios and B-allele
  frequencies from BAM/CRAM files. Note: The provided input text contained system
  error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/count-bam-lines"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-cobalt:2.2--hdfd78af_0
stdout: hmftools-cobalt.out
