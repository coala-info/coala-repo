cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - enrichAlignment
label: macse_enrichalignment
doc: "adds sequences to a pre-existing nucleotide alignment\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
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
  - id: fixed_alignment_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is set all added sequences are compared to the original alignment and their alignments are merged. This automatically sets maxINS_inSeq to 0, since the resulting alignment is meaningless otherwise (option mainly useful for metabarcoding data)."
    inputBinding:
      position: 102
      prefix: -fixed_alignment_ON
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
  - id: maxDEL_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of amino acid deletions allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxDEL_inSeq
  - id: maxFS_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of frameshifts allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxFS_inSeq
  - id: maxINS_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of internal amino acid insertions allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxINS_inSeq
  - id: maxSTOP_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of internal STOP codons allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxSTOP_inSeq
  - id: maxTotalINS_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of amino acid insertions (internal or not) allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxTotalINS_inSeq
  - id: max_NT_trimmed
    type:
      - 'null'
      - int
    doc: "if a frameshift (FS) appears near the end of the sequence, the max_NT_trimmed nucleotides can be trimmed at the beginning and/or at the end of the sequence to remove those FS and unreliable sequence extremities they pinpointed (default 0, no trimming allowed) (default: 0)"
    inputBinding:
      position: 102
      prefix: -max_NT_trimmed
  - id: new_seq_alterable_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is set, the sequences to add can be slightly altered (suppressing 1 or 2 nucleotides) to prevent FS inducing gaps in the reference alignment, so that such sequences can be added even with maxINS_inSeq set to 0 (option mainly useful for metabarcoding data)."
    inputBinding:
      position: 102
      prefix: -new_seq_alterable_ON
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
  - id: out_tested_seq_info
    type: string
    default: "macse_tested_seq_info.csv"
    doc: "output CSV file that will contain information about the number of STOP, FS and INDEL events for each tested sequence (output file name)"
    inputBinding:
      position: 102
      prefix: -out_tested_seq_info
  - id: output_only_added_seq_ON
    type:
      - 'null'
      - boolean
    doc: "with this option, only newly added sequences appear in the output alignment files, this allows to easily parallelize the enrichment when using the fixed alignment option (fixedRefAlignment): simply concatenate the multiple output FASTA files with your original alignment"
    inputBinding:
      position: 102
      prefix: -output_only_added_seq_ON
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
  - id: out_tested_seq_info_file
    type:
      - 'null'
      - File
    doc: "output CSV file that will contain information about the number of STOP, FS and INDEL events for each tested sequence"
    outputBinding:
      glob: $(inputs.out_tested_seq_info)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
