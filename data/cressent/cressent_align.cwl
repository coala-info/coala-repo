cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - align
label: cressent_align
doc: "Pipeline for sequence alignment and trimming.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: input_fasta
    type: File
    doc: "Input FASTA file with sequences"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: mafft_ep
    type:
      - 'null'
      - float
    doc: "Alignment length for MAFFT (default: 0.123)"
    inputBinding:
      position: 101
      prefix: --mafft_ep
  - id: gap_threshold
    type:
      - 'null'
      - float
    doc: "Gap threshold for TrimAl (default: 0.2)"
    inputBinding:
      position: 101
      prefix: --gap_threshold
  - id: db_family
    type:
      - 'null'
      - string
    doc: "Family names (space-separated) for specific families, 'all' to use all the database, or 'custom' to use a custom AA file"
    inputBinding:
      position: 101
      prefix: --db_family
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: "Path to the database FASTA files"
    inputBinding:
      position: 101
      prefix: --db_path
  - id: protein_type
    type:
      - 'null'
      - string
    doc: "Specify protein type (reps or caps) for database files"
    inputBinding:
      position: 101
      prefix: --protein_type
  - id: custom_aa
    type:
      - 'null'
      - File
    doc: "Path to custom AA fasta file for alignment"
    inputBinding:
      position: 101
      prefix: --custom_aa
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
