cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - join
label: seq-seq-pan_join
doc: "Join LCBs from 2 XMFA files, assigning genome_ids as in first XMFA file (-x).\n\
  \nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: name
    type: string
    doc: File prefix and sequence header for output FASTA / XFMA file
    inputBinding:
      position: 101
      prefix: --name
  - id: order
    type:
      - 'null'
      - string
    doc: Ordering of blocks in XMFA/FASTA output (0,1,2,...)
    default: '0'
    inputBinding:
      position: 101
      prefix: --order
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress warnings.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: xmfa
    type: File
    doc: XMFA input file
    inputBinding:
      position: 101
      prefix: --xmfa
  - id: xmfa_two
    type: File
    doc: XMFA file to be joined with input file.
    inputBinding:
      position: 101
      prefix: --xmfa_two
outputs:
  - id: output_path
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
