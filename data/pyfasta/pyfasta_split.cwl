cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfasta_split
label: pyfasta_split
doc: "split a fasta file into separated files.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: header_fmt
    type:
      - 'null'
      - string
    doc: "this overrides all other options. if specified, it will split the file into
      a separate file for each header. it will be a template specifying the file name
      for each new file. e.g.: \"%(fasta)s.%(seqid)s.fasta\" where 'fasta' is the
      basename of the input fasta file and seqid is the header of each entry in the
      fasta file."
    inputBinding:
      position: 102
      prefix: --header
  - id: kmers
    type:
      - 'null'
      - int
    doc: split big files into pieces of this size in basepairs. default default 
      of -1 means do not split the sequence up into k-mers, just split based on 
      the headers. a reasonable value would be 10Kbp
    default: -1
    inputBinding:
      position: 102
      prefix: --kmers
  - id: num_splits
    type: int
    doc: number of new files to create
    inputBinding:
      position: 102
      prefix: --n
  - id: overlap
    type:
      - 'null'
      - int
    doc: overlap in basepairs
    inputBinding:
      position: 102
      prefix: --overlap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_split.out
