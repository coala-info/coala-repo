cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk filter
label: slamdunk_filter
doc: "Filter BAM files based on various criteria.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Bam file(s)
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file, overrides MQ filter to 0
    inputBinding:
      position: 102
      prefix: --bed
  - id: max_nm
    type:
      - 'null'
      - int
    doc: Maximum NM for alignments
    inputBinding:
      position: 102
      prefix: --max-nm
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: --min-mq
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for mapped BAM files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
