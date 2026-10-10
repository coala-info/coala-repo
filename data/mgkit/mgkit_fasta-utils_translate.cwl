cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fasta-utils
  - translate
label: mgkit_fasta-utils_translate
doc: "Translate FASTA file in all 6 frames\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (debug messages).
    inputBinding:
      position: 101
      prefix: -v
  - id: trans_table
    type:
      - 'null'
      - string
    doc: 'Translation table: bac_plt, drs_mit, inv_mit, prt_mit, universal, vt_mit, yst_alt, yst_mit (default:
      universal)'
    inputBinding:
      position: 101
      prefix: -t
  - id: one_seq
    type:
      - 'null'
      - boolean
    doc: Only translate the sequence, instead of all 6 frames
    inputBinding:
      position: 101
      prefix: '-1'
  - id: no_wrap
    type:
      - 'null'
      - boolean
    doc: Make a sequence use only 1 line (2 including header)
    inputBinding:
      position: 101
      prefix: -w
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Shows Progress Bar
    inputBinding:
      position: 101
      prefix: --progress
  - id: fasta_file
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 102
  - id: output_file
    type: string
    doc: Output file name (written instead of standard output).
    inputBinding:
      position: 103
outputs:
  - id: output
    type: File
    doc: Translated FASTA file.
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
