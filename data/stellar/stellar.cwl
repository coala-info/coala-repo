cwlVersion: v1.2
class: CommandLineTool
baseCommand: stellar
label: stellar
doc: "STELLAR implements the SWIFT filter algorithm (Rasmussen et al., 2006) and a
  verification step for the SWIFT hits that applies local alignment, gapped X-drop
  extension, and extraction of the longest epsilon-match.\n\nInput to STELLAR are
  two files, each containing one or more sequences in FASTA format. Each sequence
  from file 1 will be compared to each sequence in file 2. The sequences from file
  1 are used as database, the sequences from file 2 as queries.\n\nTool homepage:
  https://github.com/Stellarium/stellarium"
inputs:
  - id: fasta_file_1
    type: File
    doc: 'Valid filetypes are: .fasta and .fa.'
    inputBinding:
      position: 1
  - id: fasta_file_2
    type: File
    doc: 'Valid filetypes are: .fasta and .fa.'
    inputBinding:
      position: 2
  - id: abundance_cut
    type:
      - 'null'
      - float
    doc: k-mer overabundance cut ratio. In range [0..1].
    inputBinding:
      position: 103
      prefix: --abundanceCut
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Alphabet type of input sequences (dna, rna, dna5, rna5, protein, char).
      One of dna, dna5, rna, rna5, protein, and char.
    inputBinding:
      position: 103
      prefix: --alphabet
  - id: disable_thresh
    type:
      - 'null'
      - int
    doc: Maximal number of verified matches before disabling verification for 
      one query sequence (default infinity). In range [0..inf].
    inputBinding:
      position: 103
      prefix: --disableThresh
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Maximal error rate (max 0.25). In range [0.0000001..0.25].
    inputBinding:
      position: 103
      prefix: --epsilon
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Search only in forward strand of database.
    inputBinding:
      position: 103
      prefix: --forward
  - id: kmer
    type:
      - 'null'
      - int
    doc: Length of the q-grams (max 32). In range [1..32].
    inputBinding:
      position: 103
      prefix: --kmer
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimal length of epsilon-matches. In range [0..inf].
    inputBinding:
      position: 103
      prefix: --minLength
  - id: num_matches
    type:
      - 'null'
      - int
    doc: Maximal number of kept matches per query and database. If STELLAR finds
      more matches, only the longest ones are kept.
    inputBinding:
      position: 103
      prefix: --numMatches
  - id: repeat_length
    type:
      - 'null'
      - int
    doc: Minimal length of low complexity repeats to be filtered.
    inputBinding:
      position: 103
      prefix: --repeatLength
  - id: repeat_period
    type:
      - 'null'
      - int
    doc: Maximal period of low complexity repeats to be filtered.
    inputBinding:
      position: 103
      prefix: --repeatPeriod
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Search only in reverse complement of database.
    inputBinding:
      position: 103
      prefix: --reverse
  - id: sort_thresh
    type:
      - 'null'
      - int
    doc: Number of matches triggering removal of duplicates. Choose a smaller 
      value for saving space.
    inputBinding:
      position: 103
      prefix: --sortThresh
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbosity mode.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: verification
    type:
      - 'null'
      - string
    doc: 'Verification strategy: exact or bestLocal or bandedGlobal One of exact,
      bestLocal, and bandedGlobal.'
    inputBinding:
      position: 103
      prefix: --verification
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 103
      prefix: --version-check
  - id: x_drop
    type:
      - 'null'
      - float
    doc: Maximal x-drop for extension.
    inputBinding:
      position: 103
      prefix: --xDrop
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'Name of output file. Valid filetypes are: .txt and .gff.'
    outputBinding:
      glob: $(inputs.out)
  - id: out_disabled
    type:
      - 'null'
      - File
    doc: 'Name of output file for disabled query sequences. Valid filetypes are: .fasta
      and .fa.'
    outputBinding:
      glob: $(inputs.out_disabled)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stellar:1.4.9--0
