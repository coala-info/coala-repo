cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphic
  - filter_bam
label: haphic_filter_bam
doc: "Filter BAM files (Note: The provided help text contains only container runtime
  error messages and no usage information).\n\nTool homepage: https://github.com/zengxiaofei/HapHiC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphic:1.0.7--hdfd78af_0
stdout: haphic_filter_bam.out
