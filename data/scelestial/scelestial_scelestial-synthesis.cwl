cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelestial-synthesis
label: scelestial_scelestial-synthesis
doc: "Simulates single-cell tumor sequencing data (clone tree, true and noisy sequences) for testing
  Scelestial.\n\nTool homepage: https://github.com/hzi-bifo/scelestial-paper-materials-devel"
inputs:
  - id: sample
    type:
      - 'null'
      - int
    doc: number of sampled cells
    inputBinding:
      position: 101
      prefix: --sample
  - id: step
    type:
      - 'null'
      - int
    doc: number of simulation steps
    inputBinding:
      position: 101
      prefix: --step
  - id: locus
    type:
      - 'null'
      - int
    doc: number of locuses
    inputBinding:
      position: 101
      prefix: --locus
  - id: aic
    type:
      - 'null'
      - float
    doc: advantage increase rate
    inputBinding:
      position: 101
      prefix: --aic
  - id: adc
    type:
      - 'null'
      - float
    doc: advantage decrease rate
    inputBinding:
      position: 101
      prefix: --adc
  - id: akc
    type:
      - 'null'
      - float
    doc: advantage keep rate
    inputBinding:
      position: 101
      prefix: --akc
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed number (default 7)
    inputBinding:
      position: 101
      prefix: --seed
  - id: seed_error
    type:
      - 'null'
      - int
    doc: random seed for sequencing error (default 7)
    inputBinding:
      position: 101
      prefix: --seed-error
  - id: step_mutation_rate
    type:
      - 'null'
      - float
    doc: average number of mutations in each step (default 100)
    inputBinding:
      position: 101
      prefix: --step-mutation-rate
  - id: ais
    type:
      - 'null'
      - float
    doc: advantage increase step (default 1)
    inputBinding:
      position: 101
      prefix: --ais
  - id: ads
    type:
      - 'null'
      - float
    doc: advantage decrease step (default 1)
    inputBinding:
      position: 101
      prefix: --ads
  - id: mvrate
    type:
      - 'null'
      - float
    doc: missing value rate (default 0.2)
    inputBinding:
      position: 101
      prefix: --mvrate
  - id: zorate
    type:
      - 'null'
      - float
    doc: zero to one rate (default 0.1)
    inputBinding:
      position: 101
      prefix: --zorate
  - id: ozrate
    type:
      - 'null'
      - float
    doc: one to zero rate (default 0.2)
    inputBinding:
      position: 101
      prefix: --ozrate
  - id: remove_dup
    type:
      - 'null'
      - int
    doc: remove duplicate sequences (default 0)
    inputBinding:
      position: 101
      prefix: --remove-dup
  - id: tree_grow_filter_out_child_size
    type:
      - 'null'
      - int
    doc: max child number of the clone tree, 0=inactive (default 0)
    inputBinding:
      position: 101
      prefix: --treeGrowFilterOutChildSize
  - id: samplingmethod
    type:
      - 'null'
      - int
    doc: "Sampling method: advantage/uniform (default 0)"
    inputBinding:
      position: 101
      prefix: --samplingMethod
  - id: fclone_path
    type:
      - 'null'
      - string
    doc: clones file name
    inputBinding:
      position: 102
      prefix: --fclone
  - id: fseq_path
    type:
      - 'null'
      - string
    doc: seq file name
    inputBinding:
      position: 102
      prefix: --fseq
  - id: fseqtrue_path
    type:
      - 'null'
      - string
    doc: seq (without error) filename
    inputBinding:
      position: 102
      prefix: --fseqtrue
  - id: ftree_path
    type:
      - 'null'
      - string
    doc: tree file name
    inputBinding:
      position: 102
      prefix: --ftree
outputs:
  - id: fclone
    type:
      - 'null'
      - File
    doc: clones file name
    outputBinding:
      glob: "$(inputs.fclone_path)"
  - id: fseq
    type:
      - 'null'
      - File
    doc: seq file name
    outputBinding:
      glob: "$(inputs.fseq_path)"
  - id: fseqtrue
    type:
      - 'null'
      - File
    doc: seq (without error) filename
    outputBinding:
      glob: "$(inputs.fseqtrue_path)"
  - id: ftree
    type:
      - 'null'
      - File
    doc: tree file name
    outputBinding:
      glob: "$(inputs.ftree_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelestial:1.2--h9948957_4
