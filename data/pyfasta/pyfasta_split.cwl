cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfasta
  - split
label: pyfasta_split
doc: "Split a fasta file into separated files.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: fasta
    type: File
    doc: "path to the fasta file"
    inputBinding:
      valueFrom: $(self.basename)
      position: 20
  - id: num_splits
    type:
      - 'null'
      - int
    doc: "number of new files to create"
    inputBinding:
      position: 1
      prefix: --n
  - id: overlap
    type:
      - 'null'
      - int
    doc: "overlap in basepairs"
    inputBinding:
      position: 2
      prefix: --overlap
  - id: kmers
    type:
      - 'null'
      - int
    doc: "split big files into pieces of this size in basepairs. default of -1 means do not split the sequence up into k-mers, just split based on the headers. a reasonable value would be 10Kbp"
    inputBinding:
      position: 3
      prefix: --kmers
  - id: header_fmt
    type:
      - 'null'
      - string
    doc: "if specified, split the file into a separate file for each header; template specifying the file name for each new file, e.g. \"%(fasta)s.%(seqid)s.fasta\" where 'fasta' is the basename of the input fasta file and seqid is the header of each entry in the fasta file. This overrides all other options."
    inputBinding:
      position: 4
      prefix: --header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: split_fastas
    type:
      type: array
      items: File
    doc: The split fasta files.
    outputBinding:
      glob: '*.fasta'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_split.out
