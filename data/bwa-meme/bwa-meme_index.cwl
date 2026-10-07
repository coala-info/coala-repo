cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-meme
  - index
label: bwa-meme_index
doc: "Build an index for a FASTA file using various BWT construction algorithms, including
  MEME.\n\nTool homepage: https://github.com/kaist-ina/BWA-MEME"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'BWT construction algorithm: bwtsw, is, rb2, mem2, ert or meme'
    inputBinding:
      position: 102
      prefix: -a
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix of the index [same as fasta name]
    inputBinding:
      position: 102
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads for MEME index building
    inputBinding:
      position: 102
      prefix: -t
  - id: use_64bit_names
    type:
      - 'null'
      - boolean
    doc: index files named as <in.fasta>.64.* instead of <in.fasta>.*
    inputBinding:
      position: 102
      prefix: '-6'
outputs:
  - id: index_files
    type: File[]
    doc: Index files named by the prefix (.0123, .amb, .ann, .pac, and .bwt.2bit.64 or,
      with -a meme, .pos_packed and .suffixarray_uint64)
    outputBinding:
      glob: '$(inputs.prefix ? inputs.prefix : inputs.input_fasta.basename).*'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-meme:1.0.6--hdcf5f25_2
stdout: bwa-meme_index.out
