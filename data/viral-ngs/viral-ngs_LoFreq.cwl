cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-ngs LoFreq
label: viral-ngs_LoFreq
doc: "LoFreq variant calling (Note: The provided text contains container runtime error
  messages rather than tool help text; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_LoFreq.out
