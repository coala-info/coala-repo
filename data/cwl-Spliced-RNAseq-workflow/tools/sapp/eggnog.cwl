cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - emapper.py
label: eggNOG
doc: "eggNOG is a public resource that provides Orthologous Groups (OGs)\nof proteins
  at different taxonomic levels, each with integrated and summarized functional annotations.\n"
inputs:
  - id: input_fasta
    type: File
    label: Input FASTA file containing protein sequences
    inputBinding:
      prefix: -i
  - id: db
    type:
      - string?
      - File?
    label: specify the target database for sequence searches (euk,bact,arch, 
      host:port, local hmmpressed database)
    inputBinding:
      prefix: --database
  - id: db_diamond
    type:
      - string?
      - File?
    label: Path to DIAMOND-compatible database
    inputBinding:
      prefix: --dmnd_db
  - id: data_dir
    type:
      - string?
      - Directory?
    label: Directory to use for DATA_PATH
    inputBinding:
      prefix: --data_dir
  - id: mode
    type: string?
    label: hmmer or diamond
    inputBinding:
      prefix: -m
  - id: cpu
    type: int?
    inputBinding:
      prefix: --cpu
  - id: output
    type:
      - 'null'
      - string
    doc: Output or path parameter `output`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_annotations
    type: File?
    outputBinding:
      glob: $(inputs.output)*annotations*
  - id: output_orthologs
    type: File?
    outputBinding:
      glob: $(inputs.output)*orthologs*
arguments:
  - position: 1
  - position: 2
    prefix: --annotate_hits_table
  - position: 3
    prefix: -o
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: InlineJavascriptRequirement
  - class: SoftwareRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0
