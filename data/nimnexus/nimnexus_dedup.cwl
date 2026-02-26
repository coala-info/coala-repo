cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nimnexus
  - dedup
label: nimnexus_dedup
doc: "Remove duplicate reads from the sorted bam file\n\nTool homepage: https://github.com/avsecz/nimnexus"
inputs:
  - id: bam_file
    type: File
    doc: sorted BAM file
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: number of BAM decompression threads
    default: 2
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3
stdout: nimnexus_dedup.out
