cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-align
label: ssu-align
doc: "align SSU rRNA sequences\n\nTool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: sequence_file
    type: File
    doc: sequence file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output dir
    inputBinding:
      position: 2
  - id: align_best_cm_name
    type:
      - 'null'
      - string
    doc: only align best-matching sequences to the CM named <s> in CM file
    inputBinding:
      position: 103
      prefix: --aln-one
  - id: cm_file
    type:
      - 'null'
      - File
    doc: use CM file <f> instead of the default CM file
    inputBinding:
      position: 103
      prefix: -m
  - id: force
    type:
      - 'null'
      - boolean
    doc: if dir named <output dir> already exists, empty it first
    inputBinding:
      position: 103
      prefix: -f
  - id: forward_search
    type:
      - 'null'
      - boolean
    doc: use the HMM forward algorithm for searching, not HMM viterbi
    inputBinding:
      position: 103
      prefix: --forward
  - id: global_search
    type:
      - 'null'
      - boolean
    doc: search with globally configured HMM
    inputBinding:
      position: 103
      prefix: --global
  - id: interleaved_stockholm
    type:
      - 'null'
      - boolean
    doc: output alignments in interleaved Stockholm format (not 1 line/seq)
    inputBinding:
      position: 103
      prefix: -i
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: keep intermediate files which are normally removed
    inputBinding:
      position: 103
      prefix: --keep-int
  - id: min_bit_score
    type:
      - 'null'
      - int
    doc: set minimum bit score of a surviving subsequence as <x>
    inputBinding:
      position: 103
      prefix: -b
  - id: min_length
    type:
      - 'null'
      - int
    doc: set minimum length of a surviving subsequence as <n>
    inputBinding:
      position: 103
      prefix: -l
  - id: mxsize
    type:
      - 'null'
      - string
    doc: increase mx size for cmalign to <f> Mb
    inputBinding:
      position: 103
      prefix: --mxsize
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: only search target sequence file for hits, skip alignment step
    inputBinding:
      position: 103
      prefix: --no-align
  - id: no_probabilities
    type:
      - 'null'
      - boolean
    doc: do not append posterior probabilities to alignments
    inputBinding:
      position: 103
      prefix: --no-prob
  - id: no_search
    type:
      - 'null'
      - boolean
    doc: only align target sequence file, skip initial search step
    inputBinding:
      position: 103
      prefix: --no-search
  - id: no_truncate
    type:
      - 'null'
      - boolean
    doc: do not truncate seqs to HMM predicted start/end, align full seqs
    inputBinding:
      position: 103
      prefix: --no-trunc
  - id: output_dna
    type:
      - 'null'
      - boolean
    doc: output alignments as DNA, default is RNA (even if input is DNA)
    inputBinding:
      position: 103
      prefix: --dna
  - id: rfonly
    type:
      - 'null'
      - boolean
    doc: discard inserts, only keep consensus (nongap RF) columns in alignments
    inputBinding:
      position: 103
      prefix: --rfonly
  - id: single_cm_name
    type:
      - 'null'
      - string
    doc: only search with and align to single CM named <s> in CM file
    inputBinding:
      position: 103
      prefix: -n
  - id: toponly
    type:
      - 'null'
      - boolean
    doc: only search the top strand
    inputBinding:
      position: 103
      prefix: --toponly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-align.out
