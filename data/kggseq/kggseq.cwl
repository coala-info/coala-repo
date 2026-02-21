cwlVersion: v1.2
class: CommandLineTool
baseCommand: kggseq
label: kggseq
doc: "KGGSeq is a software platform for genetic studies of human complex diseases
  and traits. (Note: The provided help text contains only system error messages and
  no usage information.)\n\nTool homepage: http://grass.cgs.hku.hk/limx/kggseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kggseq:1.1--0
stdout: kggseq.out
