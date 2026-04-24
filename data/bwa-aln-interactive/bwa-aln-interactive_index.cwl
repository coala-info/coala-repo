cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - index
label: bwa-aln-interactive_index
doc: "Index database sequences in the FASTA format\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to be indexed
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm: bwtsw, is or rb2'
    inputBinding:
      position: 102
      prefix: -a
  - id: block_size
    type:
      - 'null'
      - int
    doc: block size for the bwtsw algorithm (effective with -a bwtsw)
    inputBinding:
      position: 102
      prefix: -b
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix of the index [same as fasta name]
    inputBinding:
      position: 102
      prefix: -p
  - id: use_64bit_index
    type:
      - 'null'
      - boolean
    doc: index files named as <in.fasta>.64.* instead of <in.fasta>.*
    inputBinding:
      position: 102
      prefix: '-6'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_index.out
