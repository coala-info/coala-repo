cwlVersion: v1.2
class: CommandLineTool
baseCommand: msoma count
label: msoma_count
doc: "Count somatic mutations\n\nTool homepage: https://github.com/AkeyLab/mSOMA"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
stdout: msoma_count.out
