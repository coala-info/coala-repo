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
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: dedup_sam
    type: stdout
    doc: Deduplicated reads in SAM format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3
stdout: nimnexus_dedup.sam
