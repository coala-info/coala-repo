cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - map
label: seq-seq-pan_map
doc: "Map positions/coordinates from consensus to sequences, between sequences, ...\n\
  \nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: consensus
    type: File
    doc: consensus FASTA file used in XMFA
    inputBinding:
      position: 101
      prefix: --consensus
  - id: index
    type: File
    doc: 'File with indices to map. First line: source_seq<TAB>dest_seq[,dest_seq2,...]
      using "c" or sequence number. Then one coordinate per line. Coordinates are
      1-based!'
    inputBinding:
      position: 101
      prefix: --index
  - id: name
    type: string
    doc: File prefix and sequence header for output FASTA / XFMA file
    inputBinding:
      position: 101
      prefix: --name
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress warnings.
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_path
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
