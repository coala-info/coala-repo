cwlVersion: v1.2
class: CommandLineTool
baseCommand: mark-dups
label: hmftools-mark-dups
doc: "A tool from the HMFtools suite, likely used for marking duplicates in genomic
  data. (Note: The provided text contains only system error messages and no actual
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/mark-dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-mark-dups:1.1.7--hdfd78af_0
stdout: hmftools-mark-dups.out
