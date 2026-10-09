cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktClassifyBLAST
label: krona_ktClassifyBLAST
doc: 'Assigns each query in tabular BLAST results to an NCBI taxonomy ID. If the results
  contain comment lines, queries with no hits will be included in the output (with
  taxonomy IDs of -1 for consistency with MEGAN).


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: blast_outputs
    type:
      type: array
      items: File
    doc: File containing BLAST results in tabular format ("Hit table (text)" when
      downloading from NCBI). If running BLAST locally, subject IDs in the local database
      must contain accession numbers, either bare or in the fourth field of the pipe-separated
      ("gi|12345|xx|ABC123.1|") format.
    inputBinding:
      position: 1
  - id: use_bit_score_for_average_scores
    type:
      - 'null'
      - boolean
    doc: Use bit score for average scores instead of log[10] e-value.
    inputBinding:
      position: 102
      prefix: -b
  - id: e_value_factor
    type:
      - 'null'
      - float
    doc: E-value factor for determining "best" hits. A bit score difference threshold
      (-t) is recommended instead to avoid comparing e-values that BLAST reports as
      0 due to floating point underflow. However, an e-value factor should be used
      if the input is a concatination of BLASTs against different databases.
    inputBinding:
      position: 102
      prefix: -e
  - id: force_root_on_unknown_accessions
    type:
      - 'null'
      - boolean
    doc: If any best hits have unknown accessions, force classification to root instead
      of ignoring them.
    inputBinding:
      position: 102
      prefix: -f
  - id: use_percent_identity_for_average_scores
    type:
      - 'null'
      - boolean
    doc: Use percent identity for average scores instead of log[10] e-value.
    inputBinding:
      position: 102
      prefix: -p
  - id: random_best_hit_selection
    type:
      - 'null'
      - boolean
    doc: Pick from the best hits randomly instead of finding the lowest common ancestor.
    inputBinding:
      position: 102
      prefix: -r
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: Summarize counts and average scores by taxonomy ID.
    inputBinding:
      position: 102
      prefix: -s
  - id: bit_score_difference_threshold
    type:
      - 'null'
      - float
    doc: Threshold for bit score differences when determining "best" hits. Hits with
      scores that are within this distance of the highest score will be included when
      computing the lowest common ancestor (or picking randomly if -r is specified).
    inputBinding:
      position: 102
      prefix: -t
  - id: output_file_path
    type: string
    default: blast.taxonomy.tab
    doc: Output file name
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
