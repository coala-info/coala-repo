cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - translateNT2AA
label: macse_translatent2aa
doc: "translates nucleotides into amino acids\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
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
  - id: canonize_ON
    type:
      - 'null'
      - boolean
    doc: "if used, MACSE will output modified NT sequences so that the same codon will be used for each instance of a given amino acid (useful to generate a consensus nucleotide sequence reflecting amino acid frequencies)"
    inputBinding:
      position: 102
      prefix: -canonize_ON
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
  - id: ignore_gaps_ON
    type:
      - 'null'
      - boolean
    doc: "removes gaps before translation"
    inputBinding:
      position: 102
      prefix: -ignore_gaps_ON
  - id: keep_final_stop_ON
    type:
      - 'null'
      - boolean
    doc: "translates the final stop codons into * (OFF by default, does not work with guessOneReadingFrame)"
    inputBinding:
      position: 102
      prefix: -keep_final_stop_ON
  - id: maxSTOP_inSeq
    type:
      - 'null'
      - int
    doc: "maximum number of internal STOP codons allowed within a sequence to be actually added to the alignment (default no limit) (default: -1)"
    inputBinding:
      position: 102
      prefix: -maxSTOP_inSeq
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
  - id: seq
    type: File
    doc: "input FASTA file containing (reliable) nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -seq
  - id: trim_pending_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is enabled, the first and/or last codon(s) will be removed when incomplete (at most 4=2+2 nucleotides can be trimmed)"
    inputBinding:
      position: 102
      prefix: -trim_pending_ON
  - id: use_compressed_alphabet_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is enabled, the amino acid output file will contain the compressed amino acids corresponding to the chosen alphabet"
    inputBinding:
      position: 102
      prefix: -use_compressed_alphabet_ON
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
