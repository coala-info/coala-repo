cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/bin/poa
label: poa
doc: Align a set of sequences or alignments using the scores in MATRIXFILE.
inputs:
  - id: matrixfile
    type: File
    doc: Score matrix file
    inputBinding:
      position: 1
  - id: read_fasta
    type:
      - 'null'
      - File
    doc: Read in FASTA sequence file.
    inputBinding:
      position: 102
      prefix: -read_fasta
  - id: read_msa
    type:
      - 'null'
      - File
    doc: Read in MSA alignment file.
    inputBinding:
      position: 102
      prefix: -read_msa
  - id: read_msa2
    type:
      - 'null'
      - File
    doc: Read in second MSA file.
    inputBinding:
      position: 102
      prefix: -read_msa2
  - id: subset
    type:
      - 'null'
      - File
    doc: Filter MSA to include list of seqs in file.
    inputBinding:
      position: 102
      prefix: -subset
  - id: subset2
    type:
      - 'null'
      - File
    doc: Filter second MSA to include list of seqs in file.
    inputBinding:
      position: 102
      prefix: -subset2
  - id: remove
    type:
      - 'null'
      - File
    doc: Filter MSA to exclude list of seqs in file.
    inputBinding:
      position: 102
      prefix: -remove
  - id: remove2
    type:
      - 'null'
      - File
    doc: Filter second MSA to exclude list of seqs in file.
    inputBinding:
      position: 102
      prefix: -remove2
  - id: read_msa_list
    type:
      - 'null'
      - File
    doc: Read an MSA from each filename listed in file.
    inputBinding:
      position: 102
      prefix: -read_msa_list
  - id: tolower
    type:
      - 'null'
      - boolean
    doc: Force FASTA/MSA sequences to lowercase (nucleotides in our matrix 
      files)
    inputBinding:
      position: 102
      prefix: -tolower
  - id: toupper
    type:
      - 'null'
      - boolean
    doc: Force FASTA/MSA sequences to UPPERCASE (amino acids in our matrix 
      files)
    inputBinding:
      position: 102
      prefix: -toupper
  - id: do_global
    type:
      - 'null'
      - boolean
    doc: Do global alignment.
    inputBinding:
      position: 102
      prefix: -do_global
  - id: do_progressive
    type:
      - 'null'
      - boolean
    doc: Perform progressive alignment using a guide tree built by neighbor 
      joining from a set of sequence-sequence similarity scores.
    inputBinding:
      position: 102
      prefix: -do_progressive
  - id: read_pairscores
    type:
      - 'null'
      - File
    doc: Read tab-delimited file of similarity scores. (If not provided, scores 
      are constructed using pairwise sequence alignment.)
    inputBinding:
      position: 102
      prefix: -read_pairscores
  - id: fuse_all
    type:
      - 'null'
      - boolean
    doc: Fuse identical letters on align rings.
    inputBinding:
      position: 102
      prefix: -fuse_all
  - id: hb
    type:
      - 'null'
      - boolean
    doc: Perform heaviest bundling to generate consensi.
    inputBinding:
      position: 102
      prefix: -hb
  - id: hbmin
    type:
      - 'null'
      - float
    doc: Include in heaviest bundle sequences with percent ID (as a fraction) >=
      value.
    inputBinding:
      position: 102
      prefix: -hbmin
  - id: pir
    type:
      - 'null'
      - string
    doc: Write out MSA in PIR format.
    inputBinding:
      position: 102
      prefix: -pir
  - id: clustal
    type:
      - 'null'
      - string
    doc: Write out MSA in CLUSTAL format.
    inputBinding:
      position: 102
      prefix: -clustal
  - id: po
    type:
      - 'null'
      - string
    doc: Write out MSA in PO format.
    inputBinding:
      position: 102
      prefix: -po
  - id: preserve_seqorder
    type:
      - 'null'
      - boolean
    doc: Write out MSA with sequences in their input order.
    inputBinding:
      position: 102
      prefix: -preserve_seqorder
  - id: printmatrix
    type:
      - 'null'
      - string
    doc: Print score matrix to stdout.
    inputBinding:
      position: 102
      prefix: -printmatrix
  - id: best
    type:
      - 'null'
      - boolean
    doc: Restrict MSA output to heaviest bundles (PIR only).
    inputBinding:
      position: 102
      prefix: -best
outputs:
  - id: output_pir
    type:
      - 'null'
      - File
    doc: Write out MSA in PIR format.
    outputBinding:
      glob: $(inputs.pir)
  - id: output_clustal
    type:
      - 'null'
      - File
    doc: Write out MSA in CLUSTAL format.
    outputBinding:
      glob: $(inputs.clustal)
  - id: output_po
    type:
      - 'null'
      - File
    doc: Write out MSA in PO format.
    outputBinding:
      glob: $(inputs.po)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/poa:v2.020060928-7-deb_cv1
s:url: https://github.com/jakecreps/poastal
$namespaces:
  s: https://schema.org/
