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
  - id: bam_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `bam_path`
    inputBinding:
      position: 103
      prefix: --bam
  - id: ubam_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ubam_path`
    inputBinding:
      position: 104
      prefix: --ubam
outputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: output bam
    outputBinding:
      glob: $(inputs.bam_path)
  - id: ubam
    type:
      - 'null'
      - File
    doc: output uncompressed bam
    outputBinding:
      glob: $(inputs.ubam_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
