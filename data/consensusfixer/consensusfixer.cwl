cwlVersion: v1.2
class: CommandLineTool
baseCommand: ConsensusFixer
label: consensusfixer
doc: "Computes a consensus sequence with in-frame insertions and ambiguous nucleotides
  (wobbles) from ultra deep next-generation sequencing alignments, and provides a
  list of deletions.\n\nTool homepage: https://github.com/cbg-ethz/ConsensusFixer"
inputs:
  - id: input_bam
    type: File
    doc: Alignment file in BAM format (required). It must be indexed.
    inputBinding:
      position: 1
      prefix: -i
    secondaryFiles:
      - .bai
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Reference file in FASTA format (optional). The consensus is integrated
      into this reference.
    inputBinding:
      position: 1
      prefix: -r
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Path to the output directory (default current directory). A trailing
      slash is added, because the tool otherwise uses the value as a file name
      prefix.
    inputBinding:
      position: 1
      prefix: -o
      valueFrom: "$(self.replace(/[/]+$/, '') + '/')"
  - id: min_consensus_coverage
    type:
      - 'null'
      - int
    doc: Minimal coverage to call consensus.
    inputBinding:
      position: 1
      prefix: -mcc
  - id: min_insertion_coverage
    type:
      - 'null'
      - int
    doc: Minimal coverage to call insertion.
    inputBinding:
      position: 1
      prefix: -mic
  - id: plurality
    type:
      - 'null'
      - double
    doc: 'Minimal relative position-wise base occurence to integrate into wobble (default: 0.05).'
    inputBinding:
      position: 1
      prefix: -plurality
  - id: plurality_n
    type:
      - 'null'
      - double
    doc: 'Minimal relative position-wise gap occurence call N (default: 0.5).'
    inputBinding:
      position: 1
      prefix: -pluralityN
  - id: majority_vote
    type:
      - 'null'
      - boolean
    doc: Majority vote respecting pluralityN first, otherwise allow wobbles.
    inputBinding:
      position: 1
      prefix: -m
  - id: in_frame
    type:
      - 'null'
      - boolean
    doc: Only allow in frame insertions in the consensus.
    inputBinding:
      position: 1
      prefix: -f
  - id: remove_deletions
    type:
      - 'null'
      - boolean
    doc: Remove gaps if they are >= pluralityN.
    inputBinding:
      position: 1
      prefix: -d
  - id: maximum_insertion
    type:
      - 'null'
      - boolean
    doc: Only the insertion with the maximum frequency greater than mic is incorporated.
    inputBinding:
      position: 1
      prefix: -mi
  - id: progressive_insertion
    type:
      - 'null'
      - boolean
    doc: Progressive insertion mode, respecting mic.
    inputBinding:
      position: 1
      prefix: -pi
  - id: progressive_insertion_size
    type:
      - 'null'
      - int
    doc: 'Window size for progressive insertion mode (default: 300).'
    inputBinding:
      position: 1
      prefix: -pis
  - id: dash
    type:
      - 'null'
      - boolean
    doc: Use '-' instead of bases from the reference.
    inputBinding:
      position: 1
      prefix: -dash
  - id: single_core
    type:
      - 'null'
      - boolean
    doc: Single core mode with low memory footprint.
    inputBinding:
      position: 1
      prefix: -s
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Write position-wise statistics about the alignment (statistics.txt) and a list of deletions (deletions.txt).
    inputBinding:
      position: 1
      prefix: --stats
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print progress messages.
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: consensus
    type: File
    doc: consensus sequence
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir.replace(/[/]+$/, '') + '/' : '')consensus.fasta"
  - id: statistics
    type:
      - 'null'
      - File
    doc: position-wise alignment statistics (with --stats)
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir.replace(/[/]+$/, '') + '/' : '')statistics.txt"
  - id: deletions
    type:
      - 'null'
      - File
    doc: list of deletions (with --stats)
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir.replace(/[/]+$/, '') + '/' : '')deletions.txt"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consensusfixer:0.4--2
