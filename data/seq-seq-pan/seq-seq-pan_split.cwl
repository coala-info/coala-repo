cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - split
label: seq-seq-pan_split
doc: "Split LCBs according to chromosome annotation.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: genome_desc
    type: File
    doc: "File containing genome description (name/chromosomes) for .MAF file creation
      and 'split' task. Format: 'genome id<TAB>name<TAB>length' Length information
      is only necessary for FASTA files containing more than one chromosome. Multiple
      chromosomes of a genome must be listed in the same order as in original FASTA
      file."
    inputBinding:
      position: 101
      prefix: --genome_desc
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
