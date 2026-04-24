cwlVersion: v1.2
class: CommandLineTool
baseCommand: estscan
label: estscan
doc: "ESTScan is a program for predicting the coding regions of eukaryotic genes.\n\
  \nTool homepage: https://github.com/sib-swiss/ESTScan"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files to analyze
    inputBinding:
      position: 1
  - id: all_in_one_output
    type:
      - 'null'
      - boolean
    doc: All in one sequence output
    inputBinding:
      position: 102
      prefix: -a
  - id: analyze_positive_strand_only
    type:
      - 'null'
      - boolean
    doc: only analyze positive strand
    inputBinding:
      position: 102
      prefix: -S
  - id: compute_n_score
    type:
      - 'null'
      - int
    doc: how to compute the score of N
    inputBinding:
      position: 102
      prefix: -N
  - id: deletion_penalty
    type:
      - 'null'
      - int
    doc: deletion penalty
    inputBinding:
      position: 102
      prefix: -d
  - id: gc_correction
    type:
      - 'null'
      - float
    doc: GC select correction for score matrices
    inputBinding:
      position: 102
      prefix: -p
  - id: insertion_penalty
    type:
      - 'null'
      - int
    doc: insertion penalty
    inputBinding:
      position: 102
      prefix: -i
  - id: min_length
    type:
      - 'null'
      - int
    doc: only results longer than this length are shown
    inputBinding:
      position: 102
      prefix: -l
  - id: min_matrix_value
    type:
      - 'null'
      - int
    doc: min value in matrix
    inputBinding:
      position: 102
      prefix: -m
  - id: output_width
    type:
      - 'null'
      - int
    doc: width of the FASTA sequence output
    inputBinding:
      position: 102
      prefix: -w
  - id: remove_deleted_nucleotides
    type:
      - 'null'
      - boolean
    doc: remove deleted nucleotides from the output
    inputBinding:
      position: 102
      prefix: -n
  - id: report_best_match_header_only
    type:
      - 'null'
      - boolean
    doc: report header information for best match only
    inputBinding:
      position: 102
      prefix: -O
  - id: score_matrices_file
    type:
      - 'null'
      - File
    doc: score matrices file
    inputBinding:
      position: 102
      prefix: -M
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: only results are shown, which have scores higher than this fraction of 
      the best score
    inputBinding:
      position: 102
      prefix: -b
  - id: skip_short_sequences
    type:
      - 'null'
      - int
    doc: Skip sequences shorter than length
    inputBinding:
      position: 102
      prefix: -s
  - id: transition_log_probabilities
    type:
      - 'null'
      - type: array
        items: int
    doc: 8 integers used as log-probabilities for transitions, start->5'UTR, 
      start->CDS, start->3'UTR, 5'UTR->CDS, 5'UTR->end, CDS->3'UTR, CDS->end, 
      3'UTR->end
      - -10
      - -10
      - -5
      - -80
      - -40
      - -80
      - -40
      - -20
    inputBinding:
      position: 102
      prefix: -T
  - id: translate_to_protein_file
    type:
      - 'null'
      - File
    doc: Translate to protein. - means stdout. will go to the file and the 
      nucleotides will still go to stdout.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: send output to file. - means stdout. If both -t and -o specify stdout, 
      only proteins will be written.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/estscan:v3.0.3-3-deb_cv1
