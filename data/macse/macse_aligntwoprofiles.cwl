cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - alignTwoProfiles
label: macse_aligntwoprofiles
doc: "aligns two previously computed nucleotide alignments (also called profiles) without questioning them\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: ambi_OFF
    type:
      - 'null'
      - boolean
    doc: "disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))"
    inputBinding:
      position: 102
      prefix: -ambi_OFF
  - id: fs
    type:
      - 'null'
      - float
    doc: "cost of a frameshift in (reliable) sequences (default: 30.0)"
    inputBinding:
      position: 102
      prefix: -fs
  - id: fs_lr
    type:
      - 'null'
      - float
    doc: "cost of a frameshift in less reliable sequences (those of seq_lr file) (default: 10.0)"
    inputBinding:
      position: 102
      prefix: -fs_lr
  - id: fs_lr_term
    type:
      - 'null'
      - float
    doc: "cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence (default: 7.0)"
    inputBinding:
      position: 102
      prefix: -fs_lr_term
  - id: fs_term
    type:
      - 'null'
      - float
    doc: "cost of a terminal frameshift (those in the first and last codon) in a reliable sequence (default: 10.0)"
    inputBinding:
      position: 102
      prefix: -fs_term
  - id: gap_ext
    type:
      - 'null'
      - float
    doc: "cost of internal gap extension (default: 1.0)"
    inputBinding:
      position: 102
      prefix: -gap_ext
  - id: gap_ext_term
    type:
      - 'null'
      - float
    doc: "cost of terminal gap extension (e.g. those before the first nucleotide and after the last one) (default: 0.9)"
    inputBinding:
      position: 102
      prefix: -gap_ext_term
  - id: gap_op
    type:
      - 'null'
      - float
    doc: "cost of internal gap opening (default: 7.0)"
    inputBinding:
      position: 102
      prefix: -gap_op
  - id: gap_op_term
    type:
      - 'null'
      - float
    doc: "cost of terminal gap opening (e.g. those before the first nucleotide and after the last one) (default: 6.3)"
    inputBinding:
      position: 102
      prefix: -gap_op_term
  - id: gc_def
    type:
      - 'null'
      - int
    doc: "default genetic code specified by its standard NCBI numbering (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below)) (default: 1)"
    inputBinding:
      position: 102
      prefix: -gc_def
  - id: gc_file
    type:
      - 'null'
      - File
    doc: "tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon."
    inputBinding:
      position: 102
      prefix: -gc_file
  - id: out_AA
    type: string
    default: "macse_AA.fasta"
    doc: "output FASTA file containing aligned amino acid sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_AA
  - id: out_NT
    type: string
    default: "macse_NT.fasta"
    doc: "output FASTA file containing aligned nucleotide sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT
  - id: p1
    type: File
    doc: "FASTA file containing the first alignment/profile"
    inputBinding:
      position: 102
      prefix: -p1
  - id: p2
    type: File
    doc: "FASTA file containing the second alignment/profile"
    inputBinding:
      position: 102
      prefix: -p2
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: "amino acid score matrix to use (see list below) (default: BLOSUM62)"
    inputBinding:
      position: 102
      prefix: -score_matrix
  - id: seq
    type:
      - 'null'
      - File
    doc: "input FASTA file containing (reliable) nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -seq
  - id: seq_lr
    type:
      - 'null'
      - File
    doc: "input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)"
    inputBinding:
      position: 102
      prefix: -seq_lr
  - id: stop
    type:
      - 'null'
      - float
    doc: "cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences (default: 50.0)"
    inputBinding:
      position: 102
      prefix: -stop
  - id: stop_lr
    type:
      - 'null'
      - float
    doc: "cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences (default: 17.0)"
    inputBinding:
      position: 102
      prefix: -stop_lr
outputs:
  - id: out_AA_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned amino acid sequences"
    outputBinding:
      glob: $(inputs.out_AA)
  - id: out_NT_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.out_NT)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
