cwlVersion: v1.2
class: CommandLineTool
baseCommand: probconsRNA
label: probconsrna
doc: "PROBCONS RNA is a tool for probabilistic consistency-based multiple alignment of RNA sequences.\n\nTool homepage: http://probcons.stanford.edu/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type: File[]
    doc: "Input sequences in MFA (Multi-Fasta) format"
    inputBinding:
      position: 10
  - id: clustalw
    type:
      - 'null'
      - boolean
    doc: "use CLUSTALW output format instead of MFA"
    inputBinding:
      position: 2
      prefix: -clustalw
  - id: consistency
    type:
      - 'null'
      - int
    doc: "use 0 <= REPS <= 5 (default: 2) passes of consistency transformation"
    inputBinding:
      position: 2
      prefix: -c
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: "use 0 <= REPS <= 1000 (default: 100) passes of iterative-refinement"
    inputBinding:
      position: 2
      prefix: -ir
  - id: pre_training
    type:
      - 'null'
      - int
    doc: "use 0 <= REPS <= 20 (default: 0) rounds of pretraining"
    inputBinding:
      position: 2
      prefix: -pre
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: "generate all-pairs pairwise alignments"
    inputBinding:
      position: 2
      prefix: -pairs
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: "use Viterbi algorithm to generate all pairs (automatically enables -pairs)"
    inputBinding:
      position: 2
      prefix: -viterbi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "report progress while aligning (default: off)"
    inputBinding:
      position: 2
      prefix: -v
  - id: annot_path
    type:
      - 'null'
      - string
    doc: "write annotation for multiple alignment to FILENAME"
    inputBinding:
      position: 2
      prefix: -annot
  - id: train_path
    type:
      - 'null'
      - string
    doc: "compute EM transition probabilities, store in FILENAME (default: no training)"
    inputBinding:
      position: 2
      prefix: -t
  - id: emissions
    type:
      - 'null'
      - boolean
    doc: "also reestimate emission probabilities (default: off)"
    inputBinding:
      position: 2
      prefix: -e
  - id: paramfile
    type:
      - 'null'
      - File
    doc: "read parameters from FILENAME"
    inputBinding:
      position: 2
      prefix: -p
  - id: alignment_order
    type:
      - 'null'
      - boolean
    doc: "print sequences in alignment order rather than input order (default: off)"
    inputBinding:
      position: 2
      prefix: -a
outputs:
  - id: alignment
    type: stdout
    doc: Multiple alignment (MFA or CLUSTALW format) printed to standard output
  - id: annot
    type:
      - 'null'
      - File
    doc: annotation for the multiple alignment
    outputBinding:
      glob: $(inputs.annot_path)
  - id: train
    type:
      - 'null'
      - File
    doc: EM transition probabilities
    outputBinding:
      glob: $(inputs.train_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probconsrna:1.10--h9f5acd7_4
stdout: probconsrna.out
