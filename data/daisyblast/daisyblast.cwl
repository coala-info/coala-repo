cwlVersion: v1.2
class: CommandLineTool
baseCommand: daisyblast
label: daisyblast
doc: "DaisyBlast: A tool to find and visualize synteny blocks from a single multi-FASTA
  file.\n\nTool homepage: https://github.com/erinyoung/daisyblast"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: One or more input FASTA files (e.g., contig1.fa contig2.fa).
    inputBinding:
      position: 1
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff for the self-BLAST search.
    inputBinding:
      position: 102
      prefix: --evalue
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length *after* splitting hits.
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_pident
    type:
      - 'null'
      - float
    doc: Minimum percent identity for a BLAST hit.
    inputBinding:
      position: 102
      prefix: --min_pident
  - id: num_groups
    type:
      - 'null'
      - int
    doc: Maximum number of groups in final bedfile
    inputBinding:
      position: 102
      prefix: --num_groups
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save output .bed and .png files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daisyblast:0.2.0--pyhdfd78af_0
