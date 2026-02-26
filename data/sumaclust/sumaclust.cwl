cwlVersion: v1.2
class: CommandLineTool
baseCommand: sumaclust
label: sumaclust
doc: "star clustering of sequences.\n\nTool homepage: https://git.metabarcoding.org/obitools/sumaclust/wikis/home"
inputs:
  - id: dataset
    type:
      - 'null'
      - File
    doc: the nucleotide dataset to cluster (or nothing if the standard input 
      should be used).
    inputBinding:
      position: 1
  - id: ascending_order
    type:
      - 'null'
      - boolean
    doc: 'Sorting is in ascending order (default : descending).'
    inputBinding:
      position: 102
      prefix: -o
  - id: deactivate_fasta_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format is deactivated.
    inputBinding:
      position: 102
      prefix: -f
  - id: exact_option
    type:
      - 'null'
      - boolean
    doc: "Exact option : A sequence is assigned to the cluster with the center sequence
      presenting the highest similarity score > threshold, as opposed to the default
      'fast' option where a sequence is assigned to the first cluster found with a
      center sequence presenting a score > threshold."
    inputBinding:
      position: 102
      prefix: -e
  - id: max_ratio_variants
    type:
      - 'null'
      - float
    doc: Maximum ratio between the counts of two sequences so that the less 
      abundant one can be considered as a variant of the more abundant one.
    default: 1.0
    inputBinding:
      position: 102
      prefix: -R
  - id: multithreading
    type:
      - 'null'
      - int
    doc: 'Multithreading with ## threads using openMP.'
    inputBinding:
      position: 102
      prefix: -p
  - id: raw_score
    type:
      - 'null'
      - boolean
    doc: Raw score, not normalized.
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_length_alignment
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the alignment length (default).
    inputBinding:
      position: 102
      prefix: -a
  - id: reference_length_largest
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the largest.
    inputBinding:
      position: 102
      prefix: -L
  - id: reference_length_shortest
    type:
      - 'null'
      - boolean
    doc: Reference sequence length is the shortest.
    inputBinding:
      position: 102
      prefix: -l
  - id: replace_ns_with_as
    type:
      - 'null'
      - boolean
    doc: "n's are replaced with a's (default: sequences with n's are discarded)."
    inputBinding:
      position: 102
      prefix: -g
  - id: score_expressed_in_distance
    type:
      - 'null'
      - boolean
    doc: 'Score is expressed in distance (default : score is expressed in similarity).'
    inputBinding:
      position: 102
      prefix: -d
  - id: score_normalized_by_length
    type:
      - 'null'
      - boolean
    doc: Score is normalized by reference sequence length (default).
    inputBinding:
      position: 102
      prefix: -n
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: 'Score threshold for clustering. If the score is normalized and expressed
      in similarity (default), it is an identity, e.g. 0.95 for an identity of 95%.
      If the score is normalized and expressed in distance, it is (1.0 - identity),
      e.g. 0.05 for an identity of 95%. If the score is not normalized and expressed
      in similarity, it is the length of the Longest Common Subsequence. If the score
      is not normalized and expressed in distance, it is (reference length - LCS length).
      Only sequences with a similarity above ##.## with the center sequence of a cluster
      are assigned to that cluster.'
    default: 0.97
    inputBinding:
      position: 102
      prefix: -t
  - id: sorting_key
    type:
      - 'null'
      - string
    doc: "Sorting by ####. Must be 'None' for no sorting, or a key in the fasta header
      of each sequence, except for the count that can be computed (default : sorting
      by count)."
    default: count
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: otu_table_biom_output
    type:
      - 'null'
      - File
    doc: 'Output of the OTU table in BIOM format is activated, and written to file
      ###.'
    outputBinding:
      glob: $(inputs.otu_table_biom_output)
  - id: otu_map_output
    type:
      - 'null'
      - File
    doc: 'Output of the OTU map (observation map) is activated, and written to file
      ###.'
    outputBinding:
      glob: $(inputs.otu_map_output)
  - id: fasta_output_file
    type:
      - 'null'
      - File
    doc: 'Output in FASTA format is written to file ### instead of standard output.'
    outputBinding:
      glob: $(inputs.fasta_output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sumaclust:v1.0.31-2-deb_cv1
