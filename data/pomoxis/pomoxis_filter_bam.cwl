cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_bam
label: pomoxis_filter_bam
doc: "Filter a bam\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: input bam file.
    inputBinding:
      position: 1
  - id: accuracy
    type:
      - 'null'
      - float
    doc: Filter reads by accuracy.
    inputBinding:
      position: 102
      prefix: --accuracy
  - id: coverage
    type:
      - 'null'
      - float
    doc: "Filter reads by coverage (what fraction of the read\naligns)."
    inputBinding:
      position: 102
      prefix: --coverage
  - id: keep_supplementary
    type:
      - 'null'
      - boolean
    doc: Include supplementary alignments.
    inputBinding:
      position: 102
      prefix: --keep_supplementary
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: Include unmapped reads.
    inputBinding:
      position: 102
      prefix: --keep_unmapped
  - id: length
    type:
      - 'null'
      - int
    doc: Filter reads by read length.
    inputBinding:
      position: 102
      prefix: --length
  - id: orientation
    type:
      - 'null'
      - string
    doc: Sample only forward or reverse reads.
    inputBinding:
      position: 102
      prefix: --orientation
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: Use only primary reads.
    inputBinding:
      position: 102
      prefix: --primary_only
  - id: quality
    type:
      - 'null'
      - int
    doc: Filter reads by mean qscore.
    inputBinding:
      position: 102
      prefix: --quality
  - id: region
    type:
      - 'null'
      - string
    doc: Only process given region.
    inputBinding:
      position: 102
      prefix: --region
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads for io processing.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output bam file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
