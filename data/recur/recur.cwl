cwlVersion: v1.2
class: CommandLineTool
baseCommand: recur
label: recur
doc: "Run full RECUR analysis on a protein or codon alignment\n\nTool homepage: https://github.com/OrthoFinder/RECUR"
inputs:
  - id: input_alignment
    type: File
    doc: Protein or codon alignment in FASTA format
    inputBinding:
      position: 1
  - id: alignment_format
    type: File
    doc: Protein or codon alignment in FASTA format
    inputBinding:
      position: 102
      prefix: -f
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size used in subsitution analysis of the Monte Carlo Simulated 
      sequences
    inputBinding:
      position: 102
      prefix: -bs
  - id: constraint_tree
    type:
      - 'null'
      - File
    doc: Complete constraint tree
    inputBinding:
      position: 102
      prefix: -te
  - id: evolution_model
    type:
      - 'null'
      - string
    doc: Model of sequence evolution
    inputBinding:
      position: 102
      prefix: -m
  - id: fix_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Fix branch lengths of tree.
    inputBinding:
      position: 102
      prefix: -blfix
  - id: iqtree_threads
    type:
      - 'null'
      - int
    doc: Number of threads provided to IQ-TREE
    inputBinding:
      position: 102
      prefix: -nt
  - id: iqtree_version
    type:
      - 'null'
      - string
    doc: IQ-TREE version.
    inputBinding:
      position: 102
      prefix: -iv
  - id: num_simulated_alignments
    type:
      - 'null'
      - int
    doc: Number of simulated alignments for p-value estimation
    inputBinding:
      position: 102
      prefix: --num-alignments
  - id: outgroups
    type: string
    doc: List of outgroup sequences
    inputBinding:
      position: 102
      prefix: --outgroups
  - id: recur_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for RECUR internal processing
    inputBinding:
      position: 102
      prefix: -t
  - id: results_directory
    type:
      - 'null'
      - Directory
    doc: Results directory
    inputBinding:
      position: 102
      prefix: -o
  - id: seed
    type:
      - 'null'
      - int
    doc: Random starting see number
    inputBinding:
      position: 102
      prefix: --seed
  - id: sequence_type
    type: string
    doc: AA|CODON
    inputBinding:
      position: 102
      prefix: -st
  - id: update_cycle
    type:
      - 'null'
      - int
    doc: Update cycle used in progress bar
    inputBinding:
      position: 102
      prefix: -uc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recur:1.0.0--pyhdfd78af_0
stdout: recur.out
