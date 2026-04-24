cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiara
label: tiara
doc: "a deep-learning-based approach for identification of eukaryotic sequences in
  the metagenomic data powered by PyTorch.\n\nTool homepage: https://github.com/ibe-uw/tiara"
inputs:
  - id: cutoff
    type:
      - 'null'
      - type: array
        items: float
    doc: Probability threshold needed for classification to a class. If two 
      floats are provided, the first is used in a first stage, the second in the
      second stage
      - 0.65
      - 0.65
    inputBinding:
      position: 101
      prefix: --prob_cutoff
  - id: first_stage_kmer
    type:
      - 'null'
      - int
    doc: k-mer length used in the first stage of classification.
    inputBinding:
      position: 101
      prefix: --first_stage_kmer
  - id: gz
    type:
      - 'null'
      - boolean
    doc: Whether to gzip results or not.
    inputBinding:
      position: 101
      prefix: --gz
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Whether to gzip results or not.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: input
    type: File
    doc: A path to a fasta file.
    inputBinding:
      position: 101
      prefix: --input
  - id: k1
    type:
      - 'null'
      - int
    doc: k-mer length used in the first stage of classification.
    inputBinding:
      position: 101
      prefix: --k1
  - id: k2
    type:
      - 'null'
      - int
    doc: k-mer length used in the second stage of classification.
    inputBinding:
      position: 101
      prefix: --k2
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of a sequence. Sequences shorter than min_len are 
      discarded.
    inputBinding:
      position: 101
      prefix: --min_len
  - id: pr
    type:
      - 'null'
      - boolean
    doc: Whether to write probabilities of individual classes for each sequence 
      to the output.
    inputBinding:
      position: 101
      prefix: --pr
  - id: probabilities
    type:
      - 'null'
      - boolean
    doc: Whether to write probabilities of individual classes for each sequence 
      to the output.
    inputBinding:
      position: 101
      prefix: --probabilities
  - id: second_stage_kmer
    type:
      - 'null'
      - int
    doc: k-mer length used in the second stage of classification.
    inputBinding:
      position: 101
      prefix: --second_stage_kmer
  - id: tf
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Write sequences to fasta files specified in the arguments to this option.
      The arguments are: mit - mitochondria, pla - plastid, bac - bacteria, arc -
      archaea, euk - eukarya, unk - unknown, pro - prokarya, all - all classes present
      in input fasta (to separate fasta files).'
    inputBinding:
      position: 101
      prefix: --tf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used.
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_fasta
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Write sequences to fasta files specified in the arguments to this option.
      The arguments are: mit - mitochondria, pla - plastid, bac - bacteria, arc -
      archaea, euk - eukarya, unk - unknown, pro - prokarya, all - all classes present
      in input fasta (to separate fasta files).'
    inputBinding:
      position: 101
      prefix: --to_fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Whether to display some additional messages and progress bar during 
      classification.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: A path to output file. If not provided, the result is printed to 
      stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiara:1.0.3
