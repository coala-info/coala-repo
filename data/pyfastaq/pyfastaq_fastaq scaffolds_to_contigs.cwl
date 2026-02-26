cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - scaffolds_to_contigs
label: pyfastaq_fastaq scaffolds_to_contigs
doc: "Convert scaffolds to contigs\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: scaffolds_file
    type: File
    doc: Input scaffolds FASTA file
    inputBinding:
      position: 1
  - id: contig_sep_char
    type:
      - 'null'
      - string
    doc: 'Character to use to separate contigs. Default: >'
    default: '>'
    inputBinding:
      position: 102
      prefix: --contig-sep-char
  - id: contig_sep_len
    type:
      - 'null'
      - int
    doc: 'Length of the separator between contigs. Default: 1'
    default: 1
    inputBinding:
      position: 102
      prefix: --contig-sep-len
  - id: contig_sep_seq
    type:
      - 'null'
      - string
    doc: 'Sequence to use as separator between contigs. Default: N'
    default: N
    inputBinding:
      position: 102
      prefix: --contig-sep-seq
  - id: gap_char
    type:
      - 'null'
      - string
    doc: 'Character to use for gaps. Default: N'
    default: N
    inputBinding:
      position: 102
      prefix: --gap-char
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: 'Maximum length of a gap to be considered a gap. Default: 1000'
    default: 1000
    inputBinding:
      position: 102
      prefix: --max-gap-len
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: 'Minimum length of a contig to be outputted. Default: 1'
    default: 1
    inputBinding:
      position: 102
      prefix: --min-contig-len
  - id: min_gap_len
    type:
      - 'null'
      - int
    doc: 'Minimum length of a gap to be considered a gap. Default: 1'
    default: 1
    inputBinding:
      position: 102
      prefix: --min-gap-len
outputs:
  - id: contigs_file
    type: File
    doc: Output contigs FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
