cwlVersion: v1.2
class: CommandLineTool
baseCommand: somaticseq
label: somaticseq
doc: "SomaticSeq is an ensemble method to identify somatic mutations from NGS data.
  (Note: The provided text contains container runtime errors and does not include
  the actual help documentation for the tool.)\n\nTool homepage: http://bioinform.github.io/somaticseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
stdout: somaticseq.out
