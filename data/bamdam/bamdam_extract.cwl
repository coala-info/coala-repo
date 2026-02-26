cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam_extract
label: bamdam_extract
doc: "Extracts reads from a BAM file based on taxonomic information.\n\nTool homepage:
  https://github.com/bdesanctis/bamdam"
inputs:
  - id: in_bam
    type: File
    doc: Path to the BAM file (required)
    inputBinding:
      position: 101
      prefix: --in_bam
  - id: in_lca
    type: File
    doc: Path to the LCA file
    inputBinding:
      position: 101
      prefix: --in_lca
  - id: only_top_alignment
    type:
      - 'null'
      - boolean
    doc: Only output the best alignment for each read. If there are multiple 
      best alignments, randomly picks one
    inputBinding:
      position: 101
      prefix: --only_top_alignment
  - id: only_top_ref
    type:
      - 'null'
      - boolean
    doc: Only keep alignments to the most-hit reference
    inputBinding:
      position: 101
      prefix: --only_top_ref
  - id: tax
    type:
      - 'null'
      - type: array
        items: int
    doc: Numeric tax ID(s) to extract
    inputBinding:
      position: 101
      prefix: --tax
  - id: tax_file
    type:
      - 'null'
      - File
    doc: File of numeric tax ID(s) to extract, one per line
    inputBinding:
      position: 101
      prefix: --tax_file
outputs:
  - id: out_bam
    type: File
    doc: Path to the output BAM file
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
