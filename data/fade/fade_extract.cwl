cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ./fade
  - extract
label: fade_extract
doc: "extracts artifacts into a mapped SAM/BAM (used after annotate)\n\nTool homepage:
  https://github.com/blachlylab/fade"
inputs:
  - id: annotated_bam_sam
    type: File
    doc: Input annotated BAM/SAM file
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: output bam
    outputBinding:
      glob: $(inputs.bam)
  - id: ubam
    type:
      - 'null'
      - File
    doc: output uncompressed bam
    outputBinding:
      glob: $(inputs.ubam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
