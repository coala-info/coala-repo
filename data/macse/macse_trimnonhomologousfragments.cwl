cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - trimNonHomologousFragments
label: macse_trimnonhomologousfragments
doc: "identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
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
  - id: min_MEM_length
    type:
      - 'null'
      - int
    doc: "minimal length of the Maximum Exact Matches used to identify sequence similarity. Higher values mean more stringent filtering. (default: 6)"
    inputBinding:
      position: 102
      prefix: -min_MEM_length
  - id: min_cov
    type:
      - 'null'
      - int
    doc: "min_cov (default: 3)"
    inputBinding:
      position: 102
      prefix: -min_cov
  - id: min_homology_to_keep_seq
    type:
      - 'null'
      - float
    doc: "minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (including non-homologous NT at the beginning/end of the sequence) (default: 0.1)"
    inputBinding:
      position: 102
      prefix: -min_homology_to_keep_seq
  - id: min_internal_homology_to_keep_seq
    type:
      - 'null'
      - float
    doc: "minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (excluding non-homologous NT at the beginning/end of the sequence) (default: 0.5)"
    inputBinding:
      position: 102
      prefix: -min_internal_homology_to_keep_seq
  - id: min_trim_ext
    type:
      - 'null'
      - int
    doc: "non-homologous fragments at both extremities of a sequence are trimmed only if longer than this value (default: 60)"
    inputBinding:
      position: 102
      prefix: -min_trim_ext
  - id: min_trim_in
    type:
      - 'null'
      - int
    doc: "non-homologous fragments within the sequences are trimmed only if longer than this value (default: 90)"
    inputBinding:
      position: 102
      prefix: -min_trim_in
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
  - id: out_mask_detail
    type: string
    default: "macse_mask_detail.fasta"
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE (output file name)"
    inputBinding:
      position: 102
      prefix: -out_mask_detail
  - id: out_trace
    type:
      - 'null'
      - string
    doc: "file containing debug information"
    inputBinding:
      position: 102
      prefix: -out_trace
  - id: out_trim_info
    type: string
    default: "macse_trim_info.csv"
    doc: "output CSV file containing information about the triming/filtering process (output file name)"
    inputBinding:
      position: 102
      prefix: -out_trim_info
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: "amino acid score matrix to use (see list below) (default: BLOSUM62)"
    inputBinding:
      position: 102
      prefix: -score_matrix
  - id: seq
    type: File
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
  - id: out_mask_detail_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE"
    outputBinding:
      glob: $(inputs.out_mask_detail)
  - id: out_trace_file
    type:
      - 'null'
      - File
    doc: "file containing debug information"
    outputBinding:
      glob: $(inputs.out_trace)
  - id: out_trim_info_file
    type:
      - 'null'
      - File
    doc: "output CSV file containing information about the triming/filtering process"
    outputBinding:
      glob: $(inputs.out_trim_info)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
