cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - mapall
label: seq-seq-pan_mapall
doc: "Map all positions/coordinates from consensus to sequences\n\nTool homepage:
  https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: consensus
    type: File
    doc: consensus FASTA file used in XMFA
    inputBinding:
      position: 101
      prefix: --consensus
  - id: index
    type: File
    doc: 'File with sequences to map. First line: c<TAB>dest_seq[,dest_seq2,...] or
      source_seq[,source_seq2]<TAB>c. All following lines will be ignored.'
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for mapping all positions. Using all available
      threads if not specified.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path_path
    type: string
    doc: Output or path parameter `output_path_path`
    inputBinding:
      position: 102
      prefix: --output-path
outputs:
  - id: output_path
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
