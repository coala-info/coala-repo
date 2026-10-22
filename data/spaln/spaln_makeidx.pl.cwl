cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeidx.pl
label: spaln_makeidx.pl
doc: "makeidx.pl: format a genomic sequence or protein sequence database to be used by spaln.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: make_index
    type:
      - 'null'
      - boolean
    doc: "Make index"
    inputBinding:
      position: 10
      prefix: -i
      separate: false
  - id: aa_block
    type:
      - 'null'
      - boolean
    doc: "Make block info of aa sequences"
    inputBinding:
      position: 10
      prefix: -a
      separate: false
  - id: dna_block
    type:
      - 'null'
      - boolean
    doc: "Make block info of genomic sequence for DNA queries"
    inputBinding:
      position: 10
      prefix: -n
      separate: false
  - id: prot_block
    type:
      - 'null'
      - boolean
    doc: "Make block info of genomic sequence for aa queries"
    inputBinding:
      position: 10
      prefix: -p
      separate: false
  - id: src_dir
    type:
      - 'null'
      - string
    doc: "Directory where the source file is located (default ./)"
    inputBinding:
      position: 10
      prefix: -s
  - id: dest_dir
    type:
      - 'null'
      - string
    doc: "Directory where the database files are written (the wrapper creates it)"
    inputBinding:
      position: 10
      prefix: -d
  - id: gzipped
    type:
      - 'null'
      - boolean
    doc: "gzipped output"
    inputBinding:
      position: 10
      prefix: -g
      separate: false
  - id: fasta_file
    type: File
    doc: Genome or amino acid FASTA file (.gz allowed); staged into the working directory
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
outputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: Index and block files written by makeidx.pl
    outputBinding:
      glob: |-
        ${ var d = inputs.dest_dir ? inputs.dest_dir + '/' : ''; var b = d + inputs.fasta_file.nameroot; return [b + '.bk*', b + '.ent', b + '.grp', b + '.idx', b + '.odr', b + '.seq']; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_file)
      - entryname: $(inputs.dest_dir || '.unused_dest_dir')
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_makeidx.out
