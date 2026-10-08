cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - refineAlignment
label: macse_refinealignment
doc: "improves the input nucleotide alignment\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: align
    type: File
    doc: "input FASTA file containing aligned nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -align
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: alphabet_AA
    type:
      - 'null'
      - string
    doc: "compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments (default: SE_B_8)"
    inputBinding:
      position: 102
      prefix: -alphabet_AA
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
  - id: local_realign_dec
    type:
      - 'null'
      - float
    doc: "if smaller than 1 each refinement loop will be faster than the previous one by focusing on a smaller interval during alignment improvement steps (the lower this value the faster the refinements, possible values [0-1]) (default: 0.5)"
    inputBinding:
      position: 102
      prefix: -local_realign_dec
  - id: local_realign_init
    type:
      - 'null'
      - float
    doc: "if smaller than 1 the first refinement loop will consider only local improvement (the lower this value the faster the initial refinement, possible values [0-1]) (default: 0.5)"
    inputBinding:
      position: 102
      prefix: -local_realign_init
  - id: max_refine_iter
    type:
      - 'null'
      - int
    doc: "the max number of refinement iterations when optimizing alignment (-1 = no iteration limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -max_refine_iter
  - id: optim
    type:
      - 'null'
      - int
    doc: "optimization parameter (0 = none, 1 = basic leaf cut, 2 = standard branch cut) (default: 2)"
    inputBinding:
      position: 102
      prefix: -optim
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
