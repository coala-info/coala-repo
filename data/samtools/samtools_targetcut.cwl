cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - targetcut
label: samtools_targetcut
doc: Identify and cut target regions in BAM files
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: minQ
    inputBinding:
      position: 102
      prefix: -Q
  - id: insertion_penalty
    type:
      - 'null'
      - int
    doc: inPen
    inputBinding:
      position: 102
      prefix: -i
  - id: emission_0
    type:
      - 'null'
      - float
    doc: em0
    inputBinding:
      position: 102
      prefix: '-0'
  - id: emission_1
    type:
      - 'null'
      - float
    doc: em1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: emission_2
    type:
      - 'null'
      - float
    doc: em2
    inputBinding:
      position: 102
      prefix: '-2'
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_targetcut.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
