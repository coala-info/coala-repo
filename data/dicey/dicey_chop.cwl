cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dicey
  - chop
label: dicey_chop
doc: "Generic options:\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: chop_offset
    type:
      - 'null'
      - int
    doc: chop offset
    default: 1
    inputBinding:
      position: 102
      prefix: --jump
  - id: generate_by_chromosome
    type:
      - 'null'
      - boolean
    doc: generate reads by chromosome
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: generate_single_end
    type:
      - 'null'
      - boolean
    doc: generate single-end data
    inputBinding:
      position: 102
      prefix: --se
  - id: insert_size
    type:
      - 'null'
      - int
    doc: insert size
    default: 501
    inputBinding:
      position: 102
      prefix: --insertsize
  - id: read1_prefix
    type:
      - 'null'
      - string
    doc: read1 output prefix
    default: read1
    inputBinding:
      position: 102
      prefix: --fq1
  - id: read2_prefix
    type:
      - 'null'
      - string
    doc: read2 output prefix
    default: read2
    inputBinding:
      position: 102
      prefix: --fq2
  - id: read_length
    type:
      - 'null'
      - int
    doc: read length
    default: 101
    inputBinding:
      position: 102
      prefix: --length
  - id: reverse_complement_reads
    type:
      - 'null'
      - boolean
    doc: reverse complement all reads
    inputBinding:
      position: 102
      prefix: --revcomp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
stdout: dicey_chop.out
