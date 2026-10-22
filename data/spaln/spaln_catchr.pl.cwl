cwlVersion: v1.2
class: CommandLineTool
baseCommand: catchr.pl
label: spaln_catchr.pl
doc: "catchr.pl: catenate single or separate chromosomal sequences in a single multi-fasta file, renaming the sequence ids.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: add_chr
    type:
      - 'null'
      - string
    doc: "Add this string after the prefix to purely numeric sequence ids (-c)"
    inputBinding:
      position: 10
      prefix: -c
      separate: false
  - id: field
    type:
      - 'null'
      - int
    doc: "Use this field of the id as the new id (-f)"
    inputBinding:
      position: 10
      prefix: -f
      separate: false
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix put in front of the new sequence ids (-h; glued, plain -h prints usage)"
    inputBinding:
      position: 10
      prefix: -h
      separate: false
  - id: ignore_original_id
    type:
      - 'null'
      - boolean
    doc: "Do not use the original id as the source of the keyword search (-i)"
    inputBinding:
      position: 10
      prefix: -i
      separate: false
  - id: add_number
    type:
      - 'null'
      - boolean
    doc: "Append a running number to the new ids (-n)"
    inputBinding:
      position: 10
      prefix: -n
      separate: false
  - id: omit_old_id
    type:
      - 'null'
      - boolean
    doc: "Omit the old id from the header (-o)"
    inputBinding:
      position: 10
      prefix: -o
      separate: false
  - id: unplaced_name
    type:
      - 'null'
      - string
    doc: "Name used for unplaced sequences with -n (default Un) (-u)"
    inputBinding:
      position: 10
      prefix: -u
      separate: false
  - id: keyword
    type:
      - 'null'
      - string
    doc: "Keyword: from the top of the sequence id to the keyword (inclusive) is replaced by the prefix (-w)"
    inputBinding:
      position: 10
      prefix: -w
      separate: false
  - id: input_files
    type:
      type: array
      items: File
    doc: Input sequence files (FASTA, Genbank/DDBJ or EMBL format)
    inputBinding:
      position: 200
outputs:
  - id: fasta
    type: stdout
    doc: Concatenated multi-FASTA (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_catchr.fa
