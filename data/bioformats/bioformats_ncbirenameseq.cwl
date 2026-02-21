cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - ncbirenameseq
label: bioformats_ncbirenameseq
doc: "Change NCBI-style sequence names in a FASTA file or plain text tabular file\n
  \nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: input_file
    type: File
    doc: a file to change sequence names in
    inputBinding:
      position: 1
  - id: input_format
    type: string
    doc: a format of sequence names in input (refseq_full, genbank_full, refseq_gi,
      genbank_gi, refseq, genbank, chr_refseq, chr_genbank)
    inputBinding:
      position: 2
  - id: output_format
    type: string
    doc: a format of sequence names in output (refseq_full, genbank_full, refseq_gi,
      genbank_gi, refseq, genbank, chr_refseq, chr_genbank, ucsc)
    inputBinding:
      position: 3
  - id: chr
    type:
      - 'null'
      - File
    doc: a name of a file containing NCBI chromosome accession numbers
    inputBinding:
      position: 104
      prefix: --chr
  - id: column
    type:
      - 'null'
      - int
    doc: the number of the column that contains sequence names to be changed (1 by
      default)
    default: 1
    inputBinding:
      position: 104
      prefix: --column
  - id: comment_char
    type:
      - 'null'
      - string
    doc: a character designating comment lines in the specified plain text file
    inputBinding:
      position: 104
      prefix: --comment_char
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: the input file is of the FASTA format
    inputBinding:
      position: 104
      prefix: --fasta
  - id: no_description
    type:
      - 'null'
      - boolean
    doc: remove descriptions from FASTA sequence headers
    inputBinding:
      position: 104
      prefix: --no_description
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: remove a sequence version from an accession number
    inputBinding:
      position: 104
      prefix: --no_version
  - id: prefix
    type:
      - 'null'
      - string
    doc: a prefix to be added to sequence names
    inputBinding:
      position: 104
      prefix: --prefix
  - id: prefix_chr
    type:
      - 'null'
      - string
    doc: a prefix to be added to chromosome names
    inputBinding:
      position: 104
      prefix: --prefix_chr
  - id: prefix_unloc
    type:
      - 'null'
      - string
    doc: a prefix to be added to unlocalized fragment names
    inputBinding:
      position: 104
      prefix: --prefix_unloc
  - id: prefix_unpl
    type:
      - 'null'
      - string
    doc: a prefix to be added to unplaced fragment names
    inputBinding:
      position: 104
      prefix: --prefix_unpl
  - id: revert
    type:
      - 'null'
      - boolean
    doc: perform reverse renaming, that is, change original and new names in the renaming
      table
    inputBinding:
      position: 104
      prefix: --revert
  - id: separator
    type:
      - 'null'
      - string
    doc: a symbol separating columns in the specified plain text file
    inputBinding:
      position: 104
      prefix: --separator
  - id: suffix
    type:
      - 'null'
      - string
    doc: a suffix to be added to sequence names
    inputBinding:
      position: 104
      prefix: --suffix
  - id: suffix_chr
    type:
      - 'null'
      - string
    doc: a suffix to be added to chromosome names
    inputBinding:
      position: 104
      prefix: --suffix_chr
  - id: suffix_unloc
    type:
      - 'null'
      - string
    doc: a suffix to be added to unlocalized fragment names
    inputBinding:
      position: 104
      prefix: --suffix_unloc
  - id: suffix_unpl
    type:
      - 'null'
      - string
    doc: a suffix to be added to unplaced fragment names
    inputBinding:
      position: 104
      prefix: --suffix_unpl
  - id: unloc
    type:
      - 'null'
      - File
    doc: a name of a file containing NCBI accession numbers of unlocalized fragments
    inputBinding:
      position: 104
      prefix: --unloc
  - id: unpl
    type:
      - 'null'
      - File
    doc: a name of a file containing NCBI accession numbers of unplaced fragments
    inputBinding:
      position: 104
      prefix: --unpl
outputs:
  - id: output_file
    type: File
    doc: an output file for renamed sequences
    outputBinding:
      glob: '*.out'
  - id: output_table
    type:
      - 'null'
      - File
    doc: write the renaming table to the specified file
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
