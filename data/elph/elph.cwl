cwlVersion: v1.2
class: CommandLineTool
baseCommand: elph
label: elph
doc: "Motif finder program ELPH (Estimated Locations of Pattern Hits)\n\nTool homepage:
  https://github.com/emacsmirror/elpher"
inputs:
  - id: multi_fasta_file
    type: File
    doc: Input multi-fasta file
    inputBinding:
      position: 1
  - id: multi_fasta_file_2
    type:
      - 'null'
      - File
    doc: Second input multi-fasta file (used with -t option)
    inputBinding:
      position: 2
  - id: aac_residues
    type:
      - 'null'
      - boolean
    doc: use aac residues; default = nucleotides residues
    inputBinding:
      position: 103
      prefix: -a
  - id: brief_results
    type:
      - 'null'
      - boolean
    doc: just brief results; don't print motif
    inputBinding:
      position: 103
      prefix: -b
  - id: compute_llc
    type:
      - 'null'
      - boolean
    doc: compute Least Likely Consensus (LLC) for given motif
    inputBinding:
      position: 103
      prefix: -l
  - id: deterministic_motif
    type:
      - 'null'
      - boolean
    doc: find motif deterministically
    inputBinding:
      position: 103
      prefix: -v
  - id: deterministic_significance
    type:
      - 'null'
      - boolean
    doc: find significance deterministically
    inputBinding:
      position: 103
      prefix: -d
  - id: exact_match_motif
    type:
      - 'null'
      - boolean
    doc: 'only when an additional file is used to test the significance of the motif:
      find only the motifs that exactly match the input pattern (-m or -t options)'
    inputBinding:
      position: 103
      prefix: -e
  - id: find_motif_significance
    type:
      - 'null'
      - boolean
    doc: find significance of motif
    inputBinding:
      position: 103
      prefix: -g
  - id: global_iterations
    type:
      - 'null'
      - int
    doc: n = no of iterations to compute the global maximum
    inputBinding:
      position: 103
  - id: iterations_before_plateau
    type:
      - 'null'
      - int
    doc: n = no of iterations before deciding local maximum; plateau period 
      variable
    inputBinding:
      position: 103
      prefix: -p
  - id: local_iterations
    type:
      - 'null'
      - int
    doc: n = no of iterations to compute the local maximum
    inputBinding:
      position: 103
  - id: markov_chain_degree
    type:
      - 'null'
      - int
    doc: degree of Markov chain used to generate the random file used to test 
      the significance of the motif
    inputBinding:
      position: 103
      prefix: -n
  - id: motif
    type:
      - 'null'
      - string
    doc: use the given pattern <motif> to compute its best fit matrix to the 
      data
    inputBinding:
      position: 103
      prefix: -m
  - id: motif_length
    type:
      - 'null'
      - int
    doc: n = length of motif
    inputBinding:
      position: 103
  - id: motif_not_closest_edit_distance
    type:
      - 'null'
      - boolean
    doc: 'in conjunction with -m option: motif is not necessarily in the closest edit
      distance from input motif'
    inputBinding:
      position: 103
      prefix: -r
  - id: print_maximum_positions
    type:
      - 'null'
      - boolean
    doc: print maximum positions within sequences
    inputBinding:
      position: 103
      prefix: -x
  - id: seed
    type:
      - 'null'
      - string
    doc: sets the seed for the random generation
    inputBinding:
      position: 103
      prefix: -s
  - id: significance_iterations
    type:
      - 'null'
      - int
    doc: n = no of iterations to compute significance of motif
    inputBinding:
      position: 103
  - id: test_matrix_file
    type:
      - 'null'
      - File
    doc: test if there is significant difference between the two input files for
      a given motif matrix; <matrix> is the file containing the motif matrix
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output in <out_file> instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elph:v1.0.1-2-deb_cv1
