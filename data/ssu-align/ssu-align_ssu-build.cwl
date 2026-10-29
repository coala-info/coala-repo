cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-build
label: ssu-align_ssu-build
doc: "Build SSU rRNA covariance models (CMs) from a Stockholm alignment or from a default ssu-align-0.1 seed alignment.

Tool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: default_seed
    type:
      - 'null'
      - boolean
    doc: "command-line argument is a default ssu-align-0.1 seed alignment"
    inputBinding:
      position: 101
      prefix: -d
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force; allow overwriting of CM file"
    inputBinding:
      position: 101
      prefix: -f
  - id: cm_file_name
    type:
      - 'null'
      - string
    doc: "name the CM *file* <s>"
    inputBinding:
      position: 101
      prefix: -o
  - id: cm_name
    type:
      - 'null'
      - string
    doc: "name the CM <s>"
    inputBinding:
      position: 101
      prefix: -n
  - id: append
    type:
      - 'null'
      - string
    doc: "append this model to CM file <s>"
    inputBinding:
      position: 101
      prefix: --append
  - id: key_out
    type:
      - 'null'
      - string
    doc: "add <s> to all output file names, before the suffix"
    inputBinding:
      position: 101
      prefix: --key-out
  - id: trunc
    type:
      - 'null'
      - string
    doc: "only include consensus columns from <x> to <y> (where <s> =\"<x>-<y>\")"
    inputBinding:
      position: 101
      prefix: --trunc
  - id: num
    type:
      - 'null'
      - boolean
    doc: "output alignment with consensus columns numbered (no model will be built)"
    inputBinding:
      position: 101
      prefix: --num
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "output alignment in interleaved Stockholm (not 1 line/seq)"
    inputBinding:
      position: 101
      prefix: -i
  - id: rf
    type:
      - 'null'
      - boolean
    doc: "use consensus column (#=GC RF) annotation in alignment"
    inputBinding:
      position: 101
      prefix: --rf
  - id: gapthresh
    type:
      - 'null'
      - float
    doc: "define consensus columns as those with gap frequency <= <x> [df: 0.8]"
    inputBinding:
      position: 101
      prefix: --gapthresh
  - id: ps2pdf
    type:
      - 'null'
      - string
    doc: "command for converting ps to pdf is <s> (not \"ps2pdf\")"
    inputBinding:
      position: 101
      prefix: --ps2pdf
  - id: ps_only
    type:
      - 'null'
      - boolean
    doc: "only save postscript secondary structure diagram, no pdf"
    inputBinding:
      position: 101
      prefix: --ps-only
  - id: eent
    type:
      - 'null'
      - boolean
    doc: "use 'entropy weighting' method to achieve target relative entropy"
    inputBinding:
      position: 101
      prefix: --eent
  - id: ere
    type:
      - 'null'
      - float
    doc: "with --eent, set target relative entropy as <x>"
    inputBinding:
      position: 101
      prefix: --ere
  - id: alignment
    type:
      - 'null'
      - File
    doc: "Stockholm alignment file to build CM from"
    inputBinding:
      position: 201
  - id: seed_name
    type:
      - 'null'
      - string
    doc: "with -d: name of a default ssu-align-0.1 seed alignment ('archaea' or 'bacteria' or 'eukarya')"
    inputBinding:
      position: 202
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: CM file, log and summary files, and structure diagram
    outputBinding:
      glob:
        - '*.cm'
        - '*.ssu-build.log'
        - '*.ssu-build.sum'
        - '*.ps'
        - '*.pdf'
        - '*.stk'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-build.out
