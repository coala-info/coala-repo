cwlVersion: v1.2
class: CommandLineTool
baseCommand: phasius
label: phasius
doc: "Tool to draw a map of phaseblocks across crams/bams\n\nTool homepage: https://github.com/wdecoster/phasius"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: cram or bam files to check
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file annotation to use (bgzipped and tabix indexed)
    inputBinding:
      position: 102
      prefix: --bed
  - id: decompression
    type:
      - 'null'
      - int
    doc: Number of decompression threads to use per cram/bam
    inputBinding:
      position: 102
      prefix: --decompression
  - id: region
    type: string
    doc: region string to plot phase blocks from
    inputBinding:
      position: 102
      prefix: --region
  - id: strict
    type:
      - 'null'
      - boolean
    doc: strictly plot the begin and end of the specified interval, not the whole
      interval gathered from blocks
    inputBinding:
      position: 102
      prefix: --strict
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of crams/bams to parse in parallel
    inputBinding:
      position: 102
      prefix: --threads
  - id: width
    type:
      - 'null'
      - int
    doc: line width
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output
    type: File
    doc: HTML output file name
    outputBinding:
      glob: $(inputs.output)
  - id: summary
    type:
      - 'null'
      - File
    doc: summary file
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phasius:0.7.0--ha6fb395_0
