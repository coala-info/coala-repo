cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - targetcut
label: samtools_targetcut
doc: "Targetcut identifies and cuts target regions from a BAM file, often used for
  processing Fosmid pool sequencing data.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: emission_prob_0
    type:
      - 'null'
      - float
    doc: Emission probability 0
    inputBinding:
      position: 102
      prefix: '-0'
  - id: emission_prob_1
    type:
      - 'null'
      - float
    doc: Emission probability 1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: emission_prob_2
    type:
      - 'null'
      - float
    doc: Emission probability 2
    inputBinding:
      position: 102
      prefix: '-2'
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: insertion_penalty
    type:
      - 'null'
      - int
    doc: Insertion penalty
    inputBinding:
      position: 102
      prefix: -i
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 102
      prefix: -Q
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 102
      prefix: --reference
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_targetcut.out
