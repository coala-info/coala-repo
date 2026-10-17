cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_fasta
label: pyfastaq_fastaq_to_fasta
doc: "to_fasta\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: line_length
    type:
      - 'null'
      - int
    doc: "Number of bases on each sequence line of output file. Set to zero for no linebreaks in sequences [60]"
    inputBinding:
      position: 1
      prefix: --line_length
  - id: strip_after_whitespace
    type:
      - 'null'
      - boolean
    doc: "Remove everything after first whitespace in every sequence name"
    inputBinding:
      position: 2
      prefix: --strip_after_whitespace
  - id: check_unique
    type:
      - 'null'
      - boolean
    doc: "Die if any of the output sequence names are not unique"
    inputBinding:
      position: 3
      prefix: --check_unique
  - id: infile
    type: File
    doc: "Name of input file. Can be any of FASTA, FASTQ, GFF3, EMBL, GBK, Phylip"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
