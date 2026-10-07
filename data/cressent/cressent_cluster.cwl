cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - cluster
label: cressent_cluster
doc: "Sequence clustering using BLAST, anicalc, and aniclust.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Path to input FASTA file"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for BLAST (Default = 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: min_ani
    type:
      - 'null'
      - float
    doc: "Minimum average identity for clustering (Default = 95.0)"
    inputBinding:
      position: 101
      prefix: --min_ani
  - id: min_tcov
    type:
      - 'null'
      - float
    doc: "Minimum target coverage (Default = 85.0)"
    inputBinding:
      position: 101
      prefix: --min_tcov
  - id: min_qcov
    type:
      - 'null'
      - float
    doc: "Minimum query coverage (Default = 0.0)"
    inputBinding:
      position: 101
      prefix: --min_qcov
  - id: keep_names
    type:
      - 'null'
      - boolean
    doc: "Keep only the first word of sequence IDs, otherwise replaces space with _"
    inputBinding:
      position: 101
      prefix: --keep_names
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
