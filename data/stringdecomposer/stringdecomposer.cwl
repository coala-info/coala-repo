cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringdecomposer
label: stringdecomposer
doc: "Decomposes string into blocks alphabet\n\nTool homepage: https://github.com/ablab/stringdecomposer"
inputs:
  - id: sequences
    type: File
    doc: fasta-file with long reads or genomic sequences
    inputBinding:
      position: 101
  - id: monomers
    type: File
    doc: fasta-file with monomers
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (by default 1)
    inputBinding:
      position: 1
      prefix: --threads
  - id: out_dir
    type:
      - 'null'
      - string
    doc: output directory (by default .)
    inputBinding:
      position: 1
      prefix: --out-dir
  - id: out_file
    type:
      - 'null'
      - string
    doc: output tsv-file (by default "final_decomposition")
    inputBinding:
      position: 1
      prefix: --out-file
  - id: min_identity
    type:
      - 'null'
      - float
    doc: only monomer alignments with percent identity >= MIN_IDENTITY are printed (by default MIN_IDENTITY=0)
    inputBinding:
      position: 1
      prefix: --min-identity
  - id: scoring
    type:
      - 'null'
      - string
    doc: set scoring scheme for SD in the format "insertion,deletion,mismatch,match" (by default "-1,-1,-1,1")
    inputBinding:
      position: 1
      prefix: --scoring
  - id: batch_size
    type:
      - 'null'
      - int
    doc: set size of the batch in parallelization (by default 5000)
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: second_best
    type:
      - 'null'
      - boolean
    doc: generate second best monomer and homopolymer scores
    inputBinding:
      position: 1
      prefix: --second-best
  - id: ed_thr
    type:
      - 'null'
      - int
    doc: align only monomers with edit distance less then ed_thr for each segment (by default align all monomers)
    inputBinding:
      position: 1
      prefix: --ed_thr
outputs:
  - id: decomposition_tsv
    type:
      - 'null'
      - type: array
        items: File
    doc: Decomposition tables written by the tool
    outputBinding:
      glob: "$((inputs.out_dir || '.') + '/*.tsv')"
  - id: decomposition_extra
    type:
      - 'null'
      - type: array
        items: File
    doc: Other result files (alignment details, logs) written by the tool
    outputBinding:
      glob:
        - "$((inputs.out_dir || '.') + '/*.fa')"
        - "$((inputs.out_dir || '.') + '/*.log')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringdecomposer:1.1.2--py311he264feb_5
