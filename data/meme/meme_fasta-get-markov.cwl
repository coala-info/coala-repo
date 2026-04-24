cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-get-markov
label: meme_fasta-get-markov
doc: "Estimate a Markov model from a FASTA file of sequences. Skips tuples containing
  ambiguous symbols. Combines both strands of complementable alphabets unless -norc
  is set.\n\nTool homepage: https://meme-suite.org"
inputs:
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Input FASTA file of sequences. Reads standard input if not specified.
    inputBinding:
      position: 1
  - id: alphabet_file
    type:
      - 'null'
      - File
    doc: use the specified custom alphabet
    inputBinding:
      position: 102
      prefix: -alph
  - id: counts
    type:
      - 'null'
      - boolean
    doc: instead of a traditional Markov model output counts and skip entries with
      no counts; implies "-norc"
    inputBinding:
      position: 102
      prefix: -counts
  - id: dna
    type:
      - 'null'
      - boolean
    doc: use DNA alphabet
    inputBinding:
      position: 102
      prefix: -dna
  - id: full
    type:
      - 'null'
      - boolean
    doc: use full list of seen symbols as the alphabet
    inputBinding:
      position: 102
      prefix: -full
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not combine forward and reverse complement freqs; this is highly recommended
      for RNA sequences.
    inputBinding:
      position: 102
      prefix: -norc
  - id: nostatus
    type:
      - 'null'
      - boolean
    doc: do not print status messages.
    inputBinding:
      position: 102
      prefix: -nostatus
  - id: nosummary
    type:
      - 'null'
      - boolean
    doc: do not print the summary report even when a background file is specified.
    inputBinding:
      position: 102
      prefix: -nosummary
  - id: order
    type:
      - 'null'
      - int
    doc: order of Markov model to use
    inputBinding:
      position: 102
      prefix: -m
  - id: protein
    type:
      - 'null'
      - boolean
    doc: use protein alphabet
    inputBinding:
      position: 102
      prefix: -protein
  - id: pseudo
    type:
      - 'null'
      - float
    doc: pseudocount added to avoid probabilities of zero
    inputBinding:
      position: 102
      prefix: -pseudo
  - id: rna
    type:
      - 'null'
      - boolean
    doc: use rna alphabet
    inputBinding:
      position: 102
      prefix: -rna
outputs:
  - id: background_file
    type:
      - 'null'
      - File
    doc: Output file for the Markov model. Writes standard output if not specified.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
