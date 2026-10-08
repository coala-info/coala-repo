cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq-seq-pan
  - resolve
label: seq-seq-pan_resolve
doc: "Resolve LCBs stretching over delimiter sequences.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: consensus
    type: File
    secondaryFiles:
      - pattern: .idx
      - pattern: .blockseparated.fasta
      - pattern: .blockseparated.idx
    doc: consensus FASTA file used in XMFA
    inputBinding:
      position: 101
      prefix: --consensus
      valueFrom: $(self.basename)
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
      - entry: $(inputs.consensus)
      - entryname: $(inputs.output_path_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
