cwlVersion: v1.2
class: CommandLineTool
baseCommand: paired_end_read_merger
label: smallgenomeutilities_paired_end_read_merger
doc: "Merges paired-end reads to one fused reads based on alignment.\n\nTool homepage:
  https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: input_sam
    type: File
    doc: input SAM file (sorted by QNAME)
    inputBinding:
      position: 1
  - id: quality_n
    type:
      - 'null'
      - string
    doc: PHRED quality to use when filling gap with n. (e.g. 0 or 2)
    inputBinding:
      position: 102
      prefix: --quality-n
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all output except errors
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference file used during alignment
    inputBinding:
      position: 102
      prefix: --ref
  - id: unaligned_sam
    type:
      - 'null'
      - File
    doc: file to write unaligned reads to (if not specified, unaligned reads are
      skipped)
    inputBinding:
      position: 102
      prefix: --unaligned
  - id: unpaired_sam
    type:
      - 'null'
      - File
    doc: file to write unpaired reads to (defaults to same as output)
    inputBinding:
      position: 102
      prefix: --unpaired
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose debugging output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_sam
    type:
      - 'null'
      - File
    doc: file to write merged read-pairs to
    outputBinding:
      glob: $(inputs.output_sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
