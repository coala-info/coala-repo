cwlVersion: v1.2
class: CommandLineTool
baseCommand: fimo
label: meme_fimo
doc: "Find Individual Motif Occurrences (FIMO) searches a sequence database for occurrences
  of known motifs.\n\nTool homepage: https://meme-suite.org"
inputs:
  - id: motif_file
    type: File
    doc: File containing one or more motifs
    inputBinding:
      position: 1
  - id: sequence_file
    type: File
    doc: File containing sequences to search
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - float
    doc: Alpha parameter for position-specific priors
    inputBinding:
      position: 103
      prefix: --alpha
  - id: best_site
    type:
      - 'null'
      - boolean
    doc: Only output the best site for each motif in each sequence
    inputBinding:
      position: 103
      prefix: --best-site
  - id: bfile
    type:
      - 'null'
      - File
    doc: Background model file
    inputBinding:
      position: 103
      prefix: --bfile
  - id: max_stored_scores
    type:
      - 'null'
      - int
    doc: Maximum number of scores to store
    inputBinding:
      position: 103
      prefix: --max-stored-scores
  - id: max_strand
    type:
      - 'null'
      - boolean
    doc: If both strands are scanned, report only the best match
    inputBinding:
      position: 103
      prefix: --max-strand
  - id: motif
    type:
      - 'null'
      - string
    doc: Use only the motif identified by <id>
    inputBinding:
      position: 103
      prefix: --motif
  - id: motif_pseudo
    type:
      - 'null'
      - float
    doc: Pseudocount to add to motif frequencies
    inputBinding:
      position: 103
      prefix: --motif-pseudo
  - id: no_pgc
    type:
      - 'null'
      - boolean
    doc: Do not use p-value-based genomic control
    inputBinding:
      position: 103
      prefix: --no-pgc
  - id: no_qvalue
    type:
      - 'null'
      - boolean
    doc: Do not compute q-values
    inputBinding:
      position: 103
      prefix: --no-qvalue
  - id: norc
    type:
      - 'null'
      - boolean
    doc: Do not scan the reverse complement strand
    inputBinding:
      position: 103
      prefix: --norc
  - id: prior_dist
    type:
      - 'null'
      - File
    doc: PSP distribution filename
    inputBinding:
      position: 103
      prefix: --prior-dist
  - id: psp
    type:
      - 'null'
      - File
    doc: Position-specific priors filename
    inputBinding:
      position: 103
      prefix: --psp
  - id: qv_thresh
    type:
      - 'null'
      - boolean
    doc: Use q-values for the threshold instead of p-values
    inputBinding:
      position: 103
      prefix: --qv-thresh
  - id: skip_matched_sequence
    type:
      - 'null'
      - boolean
    doc: Do not include the sequence of the match in the output
    inputBinding:
      position: 103
      prefix: --skip-matched-sequence
  - id: text
    type:
      - 'null'
      - boolean
    doc: Output in text format (no directory created)
    inputBinding:
      position: 103
      prefix: --text
  - id: thresh
    type:
      - 'null'
      - float
    doc: p-value or q-value threshold
    inputBinding:
      position: 103
      prefix: --thresh
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level (1-5)
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Name of output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_clobber
    type:
      - 'null'
      - Directory
    doc: Name of output directory, allowing overwriting
    outputBinding:
      glob: $(inputs.output_dir_clobber)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
