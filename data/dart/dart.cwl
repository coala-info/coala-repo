cwlVersion: v1.2
class: CommandLineTool
baseCommand: dart
label: dart
doc: "DART v1.4.6 (Hsin-Nan Lin & Wen-Lian Hsu)\n\nTool homepage: https://github.com/hsinnan75/Dart"
inputs:
  - id: alignment_output_bam
    type: boolean
    doc: alignment filename in BAM format
    inputBinding:
      position: 101
      prefix: -bo
  - id: alignment_output_sam
    type: boolean
    doc: alignment filename in SAM format
    inputBinding:
      position: 101
      prefix: -o
  - id: detect_all_splice_junctions
    type:
      - 'null'
      - boolean
    doc: detect all splice junction regardless of mapq score
    inputBinding:
      position: 101
      prefix: -all_sj
  - id: index_prefix
    type: string
    doc: Index_Prefix
    inputBinding:
      position: 101
      prefix: -i
  - id: interlaced_paired_end_reads
    type:
      - 'null'
      - boolean
    doc: paired-end reads are interlaced in the same file
    inputBinding:
      position: 101
      prefix: -p
  - id: junction_output_file
    type:
      - 'null'
      - File
    doc: splice junction output filename
    inputBinding:
      position: 101
      prefix: -j
  - id: max_dup
    type:
      - 'null'
      - int
    doc: maximal number of repetitive fragments (between 100-10000)
    inputBinding:
      position: 101
      prefix: -max_dup
  - id: max_intron_size
    type:
      - 'null'
      - int
    doc: the maximal intron size
    inputBinding:
      position: 101
      prefix: -max_intron
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximal number of mismatches in an alignment
    inputBinding:
      position: 101
      prefix: -mis
  - id: min_intron_size
    type:
      - 'null'
      - int
    doc: the minimal intron size
    inputBinding:
      position: 101
      prefix: -min_intron
  - id: output_multiple_alignments
    type:
      - 'null'
      - boolean
    doc: output multiple alignments
    inputBinding:
      position: 101
      prefix: -m
  - id: output_unique_alignments
    type:
      - 'null'
      - boolean
    doc: output unique alignments
    inputBinding:
      position: 101
      prefix: -unique
  - id: read_files_a1
    type:
      type: array
      items: File
    doc: 'files with #1 mates reads'
    inputBinding:
      position: 101
      prefix: -f
  - id: read_files_a2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'files with #2 mates reads'
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dart:1.4.6--h13024bc_7
stdout: dart.out
