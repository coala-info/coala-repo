cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - gbseqextractor
label: mitoz_tools_gbseqextractor
doc: "Extract any CDS, rRNA, tRNA or whole sequences of genes from a GenBank file. Seqid will be the value of '/gene=' or '/product='; genes with neither are not output.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: genbank_file
    type: File
    doc: "Genbank file"
    inputBinding:
      position: 1
      prefix: -f
  - id: prefix
    type: string
    doc: "prefix of output file. required."
    inputBinding:
      position: 2
      prefix: -prefix
  - id: seq_prefix
    type:
      - 'null'
      - string
    doc: "prefix of each seq id. default: None"
    inputBinding:
      position: 3
      prefix: -seqPrefix
  - id: types
    type:
      - 'null'
      - string[]
    doc: "what kind of genes you want to extract (CDS, rRNA, tRNA, wholeseq, gene)? wholeseq for whole fasta seq. Each sequence in the result files corresponds to ONE feature in the GenBank file. [CDS]"
    inputBinding:
      position: 4
      prefix: -types
  - id: cds_translation
    type:
      - 'null'
      - boolean
    doc: "Also output translated CDS (required -types CDS). The translations are retrived directly from the '/translation=' key word. [False]"
    inputBinding:
      position: 5
      prefix: -cds_translation
  - id: use_gi
    type:
      - 'null'
      - boolean
    doc: "use gi number as sequence ID instead of accession number when gi number is present. (default: accession number)"
    inputBinding:
      position: 6
      prefix: -gi
  - id: position_info
    type:
      - 'null'
      - boolean
    doc: "output the position information on the ID line. Warning: the position on ID line is 0 left-most! [False]"
    inputBinding:
      position: 7
      prefix: -p
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: "output the taxonomy lineage on ID line [False]"
    inputBinding:
      position: 8
      prefix: -t
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: "reverse and complement the output sequences if they are on the 3 to 5 direction [True]"
    inputBinding:
      position: 9
      prefix: -rv
  - id: species_name
    type:
      - 'null'
      - boolean
    doc: "output the species name on the ID line [False]"
    inputBinding:
      position: 10
      prefix: -s
  - id: seq_length
    type:
      - 'null'
      - boolean
    doc: "output the seq length on the ID line [False]"
    inputBinding:
      position: 11
      prefix: -l
  - id: full_length_only
    type:
      - 'null'
      - boolean
    doc: "only output full length genes, i.e., exclude the genes with '>' or '<' in their location [False]"
    inputBinding:
      position: 12
      prefix: -F
outputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: "FASTA files written with the output prefix (one per gene type)."
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
