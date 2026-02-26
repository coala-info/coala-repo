cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/lib/tigr-glimmer/score-fixed
label: tigr-glimmer_score-fixed
doc: 'Read sequences from stdin and score them using fixed-length model in file <model>.
  Output scores to stdout. Output columns are: sequence number, positive total score,
  positive score per base, negative total score, negative score per base, delta positive/negative
  per-base scores.'
inputs:
  - id: pos_model
    type: File
    doc: Positive model file
    inputBinding:
      position: 1
  - id: neg_model
    type: File
    doc: Negative model file
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: Input file (reads from stdin)
    inputBinding:
      position: 3
  - id: output_simple_format
    type:
      - 'null'
      - boolean
    doc: Output simple format of string num and 1 or -1
    inputBinding:
      position: 104
      prefix: -s
  - id: use_null_negative_model
    type:
      - 'null'
      - boolean
    doc: Use NULL negative model, i.e., constant zero
    inputBinding:
      position: 104
      prefix: -N
  - id: use_regular_icm
    type:
      - 'null'
      - boolean
    doc: Negative model is regular ICM, not fixed-length ICM
    inputBinding:
      position: 104
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdout: tigr-glimmer_score-fixed.out
