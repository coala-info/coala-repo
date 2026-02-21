cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmftools-bwa-plus
label: hmftools-bwa-plus
doc: "HMFtools BWA Plus (Note: The provided text contains system error messages and
  does not include usage instructions or argument definitions.)\n\nTool homepage:
  https://github.com/hartwigmedical/bwa-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bwa-plus:1.0.0--h077b44d_0
stdout: hmftools-bwa-plus.out
