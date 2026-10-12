cwlVersion: v1.2
class: CommandLineTool
baseCommand: peekseq.pl
label: peekseq_peekseq.pl
doc: "PeekSeq: A tool for analyzing FASTA sequences with specific length and translation
  table options.\n\nTool homepage: https://github.com/bcgsc/peekseq"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA (DNA/RNA) file
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code translation table id
    inputBinding:
      position: 101
      prefix: -c
  - id: length
    type:
      - 'null'
      - int
    doc: length
    inputBinding:
      position: 101
      prefix: -k
  - id: output_tsv
    type:
      - 'null'
      - int
    doc: 'output tsv file (option, -v 1==yes -v 0==no [default])'
    inputBinding:
      position: 101
      prefix: -v
  - id: min_region_size
    type:
      - 'null'
      - int
    doc: min. reference FASTA region [size] (bp) to output
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Coding DNA and protein FASTA files, log and optional k-mer frame table (peekseq_v*)
    outputBinding:
      glob: peekseq_v*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peekseq:0.0.1--hdfd78af_0
stdout: peekseq_peekseq.pl.out
