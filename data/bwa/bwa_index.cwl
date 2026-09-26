cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - index
label: bwa_index
doc: "Index database sequences in the FASTA format\n\nWrites the index files
  <prefix>.amb, .ann, .bwt, .pac and .sa.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_fasta
    type: File
    doc: Input fasta file
    inputBinding:
      position: 200
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm: bwtsw, is or rb2'
    inputBinding:
      position: 101
      prefix: -a
  - id: block_size
    type:
      - 'null'
      - int
    doc: block size for the bwtsw algorithm (effective with -a bwtsw)
    inputBinding:
      position: 101
      prefix: -b
  - id: index_64
    type:
      - 'null'
      - boolean
    doc: build the index for a large (64-bit) reference; the files are still named <prefix>.*, because prefix_path sets the prefix
    inputBinding:
      position: 101
      prefix: '-6'
  - id: prefix_path
    type: string
    doc: Prefix of the index files, usually the fasta file name (for example
      ref.fa); any directory part is dropped
    inputBinding:
      position: 102
      prefix: -p
      valueFrom: $(self.split('/').pop())
outputs:
  - id: index_files
    type: File[]
    doc: The index files <prefix>.amb, .ann, .bwt, .pac and .sa
    outputBinding:
      glob: $(inputs.prefix_path.split('/').pop()).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
