cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coverage_from_bam
label: pomoxis_coverage_from_bam
doc: "Calculate read coverage depth from a bam.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input bam/sam file (indexed).
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: Use only primary reads (default on).
    inputBinding:
      position: 102
      prefix: --primary_only
  - id: keep_supplementary
    type:
      - 'null'
      - boolean
    doc: Include supplementary alignments.
    inputBinding:
      position: 102
      prefix: --keep_supplementary
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process the given regions.
    inputBinding:
      position: 102
      prefix: --regions
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output, defaults to the basename of the bam.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: one_file
    type:
      - 'null'
      - string
    doc: Single output file with a "region" column.
    inputBinding:
      position: 102
      prefix: --one_file
  - id: stride
    type:
      - 'null'
      - int
    doc: Stride in genomic coordinate (default 1000).
    inputBinding:
      position: 102
      prefix: --stride
  - id: summary_only
    type:
      - 'null'
      - boolean
    doc: Output only the depth_summary.txt file.
    inputBinding:
      position: 102
      prefix: --summary_only
  - id: orientation
    type:
      - 'null'
      - string
    doc: 'Sample only forward or reverse reads: fwd or rev.'
    inputBinding:
      position: 102
      prefix: --orientation
  - id: quality
    type:
      - 'null'
      - float
    doc: Filter reads by mean qscore.
    inputBinding:
      position: 102
      prefix: --quality
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
    doc: Filter reads by coverage (what fraction of the read aligns).
    inputBinding:
      position: 102
      prefix: --coverage
  - id: length
    type:
      - 'null'
      - int
    doc: Filter reads by read length.
    inputBinding:
      position: 102
      prefix: --length
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: Include unmapped reads.
    inputBinding:
      position: 102
      prefix: --keep_unmapped
outputs:
  - id: depth_files
    type: File[]
    doc: Depth file per reference sequence and the depth summary.
    outputBinding:
      glob:
        - '*.depth.txt'
        - '*depth_summary.txt'
  - id: one_file_out
    type:
      - 'null'
      - File
    doc: Single depth file with a region column (--one_file).
    outputBinding:
      glob: $(inputs.one_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
