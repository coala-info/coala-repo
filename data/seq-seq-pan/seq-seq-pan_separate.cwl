cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq-seq-pan
  - separate
label: seq-seq-pan_separate
doc: "Separate small multi-sequence LCBs to form genome specific entries.\n\nTool
  homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: length
    type:
      - 'null'
      - int
    doc: Length of "small LCB".
    inputBinding:
      position: 101
      prefix: --length
  - id: name
    type: string
    doc: File prefix and sequence header for output FASTA / XFMA file
    inputBinding:
      position: 101
      prefix: --name
  - id: order
    type:
      - 'null'
      - int
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
  - id: output_path_path
    type: string
    inputBinding:
      position: 102
      prefix: --output_path
outputs:
  - id: output_path
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
