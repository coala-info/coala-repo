cwlVersion: v1.2
class: CommandLineTool
baseCommand: plncpro_build
label: plncpro_build
doc: "This script generates classification model from codin and non coding transcripts\n\
  \nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: blast_database
    type: File
    doc: path to blast database
    inputBinding:
      position: 101
      prefix: -d
  - id: cleanup_intermediate
    type:
      - 'null'
      - boolean
    doc: clean up intermediate files
    inputBinding:
      position: 101
      prefix: -r
  - id: min_length
    type:
      - 'null'
      - int
    doc: specifiy min_length to filter input files
    inputBinding:
      position: 101
      prefix: --min_len
  - id: model_name
    type: string
    doc: output model name
    inputBinding:
      position: 101
      prefix: --model
  - id: negative_blast_results
    type:
      - 'null'
      - File
    doc: path to blast output for negative input file
    inputBinding:
      position: 101
      prefix: --neg_blastres
  - id: non_coding_examples
    type: File
    doc: path to file containing non coding examples
    inputBinding:
      position: 101
      prefix: --neg
  - id: num_trees
    type:
      - 'null'
      - int
    doc: number of trees
    inputBinding:
      position: 101
      prefix: --trees
  - id: output_directory
    type: Directory
    doc: output directory name to store all results
    inputBinding:
      position: 101
      prefix: --outdir
  - id: positive_blast_results
    type:
      - 'null'
      - File
    doc: path to blast output for positive input file
    inputBinding:
      position: 101
      prefix: --pos_blastres
  - id: positive_examples
    type: File
    doc: path to file containing protein coding examples
    inputBinding:
      position: 101
      prefix: --pos
  - id: qcov_hsp
    type:
      - 'null'
      - int
    doc: specify qcov parameter for blast
    inputBinding:
      position: 101
      prefix: --qcov_hsp
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: use_blast
    type:
      - 'null'
      - boolean
    doc: Don't use blast features
    inputBinding:
      position: 101
      prefix: --noblast
  - id: use_ff
    type:
      - 'null'
      - boolean
    doc: Don't use framefinder features
    inputBinding:
      position: 101
      prefix: --no_ff
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more messages
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
stdout: plncpro_build.out
