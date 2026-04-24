cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqseqpan.py
  - remove
label: seq-seq-pan_remove
doc: "Remove a genome from all LCBs in alignment.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
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
  - id: remove_genome
    type: int
    doc: Number of genome to remove (as shown in XMFA header)
    inputBinding:
      position: 101
      prefix: --removegenome
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
