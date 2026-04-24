cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrimo
label: meme_centrimo
doc: "CentriMo (Local Motif Enrichment Analysis) - identifies motifs that are enriched
  in the center of sequences.\n\nTool homepage: https://meme-suite.org"
inputs:
  - id: sequence_file
    type: File
    doc: Input sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: motif_files
    type:
      type: array
      items: File
    doc: One or more motif files
    inputBinding:
      position: 2
  - id: background_model
    type:
      - 'null'
      - File
    doc: '0-order background frequency model for PWMs; default: base frequencies in
      input sequences'
    inputBinding:
      position: 103
      prefix: --bfile
  - id: center_distance
    type:
      - 'null'
      - boolean
    doc: 'distance to sequence center enrichment; default: region enrichment'
    inputBinding:
      position: 103
      prefix: --cd
  - id: custom_alphabet
    type:
      - 'null'
      - File
    doc: name of the file containing a custom alphabet, which specifies that motifs
      should be converted
    inputBinding:
      position: 103
      prefix: --xalph
  - id: description
    type:
      - 'null'
      - string
    doc: include the description in the output
    inputBinding:
      position: 103
      prefix: --desc
  - id: description_file
    type:
      - 'null'
      - File
    doc: use the file content as the description
    inputBinding:
      position: 103
      prefix: --dfile
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: evalue threshold for including in results
    inputBinding:
      position: 103
      prefix: --ethresh
  - id: exclude_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: 'name pattern to exclude as motif; may be repeated; default: all motifs are
      used'
    inputBinding:
      position: 103
      prefix: --exc
  - id: flip
    type:
      - 'null'
      - boolean
    doc: "'flip' sequences so that matches on the reverse strand are 'reflected' around
      center"
    inputBinding:
      position: 103
      prefix: --flip
  - id: include_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: 'name pattern to select as motif; may be repeated; default: all motifs are
      used'
    inputBinding:
      position: 103
      prefix: --inc
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'compute the enrichment of all regions; default: enrichment of central regions
      only'
    inputBinding:
      position: 103
      prefix: --local
  - id: max_region_width
    type:
      - 'null'
      - int
    doc: 'maximum width of any region to consider; default: use the sequence length'
    inputBinding:
      position: 103
      prefix: --maxreg
  - id: min_region_width
    type:
      - 'null'
      - int
    doc: minimum width of any region to consider; must be less than <maxreg>
    inputBinding:
      position: 103
      prefix: --minreg
  - id: motif_pseudo
    type:
      - 'null'
      - int
    doc: pseudo-count to use creating PWMs
    inputBinding:
      position: 103
      prefix: --motif-pseudo
  - id: neg_sequences
    type:
      - 'null'
      - File
    doc: plot motif distributions in this set as well in the <sequence file> (positive
      sequences) and compute the relative enrichment
    inputBinding:
      position: 103
      prefix: --neg
  - id: no_rc
    type:
      - 'null'
      - boolean
    doc: do not scan with the reverse complement motif
    inputBinding:
      position: 103
      prefix: --norc
  - id: no_seq_ids
    type:
      - 'null'
      - boolean
    doc: do not store sequence IDs in HTML output
    inputBinding:
      position: 103
      prefix: --noseq
  - id: optimize_score
    type:
      - 'null'
      - boolean
    doc: search for optimized score above the threshold given by '--score' argument
    inputBinding:
      position: 103
      prefix: --optimize-score
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: score threshold for PWMs, in bits; sequences without a site with score >=
      <S> are ignored
    inputBinding:
      position: 103
      prefix: --score
  - id: separate_rc
    type:
      - 'null'
      - boolean
    doc: scan separately with reverse complement motif; (implies --norc)
    inputBinding:
      position: 103
      prefix: --sep
  - id: sequence_length
    type:
      - 'null'
      - int
    doc: 'use sequences with this length; default: use sequences with the same length
      as the first'
    inputBinding:
      position: 103
      prefix: --seqlen
  - id: use_lo_fraction
    type:
      - 'null'
      - boolean
    doc: score threshold <S> is fraction of maximum log-odds
    inputBinding:
      position: 103
      prefix: --use-lo-fraction
  - id: use_pvalues
    type:
      - 'null'
      - boolean
    doc: use p-values instead of PWM scores
    inputBinding:
      position: 103
      prefix: --use-pvalues
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity of output: 1 (quiet) - 4 (dump)'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_overwrite
    type:
      - 'null'
      - Directory
    doc: allow overwriting output directory
    outputBinding:
      glob: $(inputs.output_dir_overwrite)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
