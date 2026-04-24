cwlVersion: v1.2
class: CommandLineTool
baseCommand: kart
label: kart
doc: "kart v2.5.6 (Hsin-Nan Lin & Wen-Lian Hsu)\n\nTool homepage: https://github.com/hsinnan75/Kart"
inputs:
  - id: index_prefix
    type: string
    doc: Index_Prefix
    inputBinding:
      position: 101
      prefix: -i
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: max gaps (indels)
    inputBinding:
      position: 101
      prefix: -g
  - id: output_multiple_alignments
    type:
      - 'null'
      - boolean
    doc: output multiple alignments
    inputBinding:
      position: 101
      prefix: -m
  - id: pacbio_data
    type:
      - 'null'
      - boolean
    doc: pacbio data
    inputBinding:
      position: 101
      prefix: -pacbio
  - id: paired_end_interlaced
    type:
      - 'null'
      - boolean
    doc: paired-end reads are interlaced in the same file
    inputBinding:
      position: 101
      prefix: -p
  - id: read_files_1
    type:
      type: array
      items: File
    doc: 'files with #1 mates reads (format:fa, fq, fq.gz)'
    inputBinding:
      position: 101
      prefix: -f
  - id: read_files_2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'files with #2 mates reads (format:fa, fq, fq.gz)'
    inputBinding:
      position: 101
      prefix: -f2
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_sam
    type:
      - 'null'
      - File
    doc: alignment filename in SAM format
    outputBinding:
      glob: $(inputs.output_sam)
  - id: output_bam
    type:
      - 'null'
      - File
    doc: alignment filename in BAM format
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kart:2.5.6--h13024bc_6
