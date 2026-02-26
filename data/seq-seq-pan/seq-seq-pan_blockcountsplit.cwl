cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - blockcountsplit
label: seq-seq-pan_blockcountsplit
doc: "Split XMFA of 2 genomes into 3 XMFA files: blocks with both genomes and genome-specific
  blocks for each genome.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
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
