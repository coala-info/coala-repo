cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - realign
label: seq-seq-pan_realign
doc: "Realign sequences of LCBs around consecutive gaps. Can only be used with two
  aligned sequences.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: blat_path
    type:
      - 'null'
      - File
    doc: Path to blat binary if not in $PATH.
    inputBinding:
      position: 101
      prefix: --blat
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
outputs:
  - id: output_path
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
