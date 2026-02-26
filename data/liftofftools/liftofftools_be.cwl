cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools_be
doc: "liftofftools: error: argument subcommand: invalid choice: 'be' (choose from
  'clusters', 'variants', 'synteny', 'all')\n\nTool homepage: https://github.com/agshumate/LiftoffTools"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (clusters, variants, synteny, all)
    inputBinding:
      position: 1
  - id: chain_file
    type:
      - 'null'
      - File
    doc: Chain file
    inputBinding:
      position: 102
      prefix: -f
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: Calculate edit distance
    inputBinding:
      position: 102
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 102
  - id: infer_genes
    type:
      - 'null'
      - boolean
    doc: Infer genes
    inputBinding:
      position: 102
  - id: mmseqs_params
    type:
      - 'null'
      - string
    doc: Parameters for mmseqs
    inputBinding:
      position: 102
  - id: mmseqs_path
    type:
      - 'null'
      - string
    doc: Path to mmseqs executable
    inputBinding:
      position: 102
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -dir
  - id: reference_genome
    type: string
    doc: Reference genome
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_genome_annotation
    type: string
    doc: Reference genome GFF/GTF or DB
    inputBinding:
      position: 102
      prefix: -tg
  - id: reference_sort
    type:
      - 'null'
      - string
    doc: Sort reference genome
    inputBinding:
      position: 102
  - id: target_genome
    type: string
    doc: Target genome GFF/GTF or DB
    inputBinding:
      position: 102
      prefix: -t
  - id: target_genome_annotation
    type: string
    doc: Target genome GFF/GTF or DB
    inputBinding:
      position: 102
      prefix: -rg
  - id: target_sort
    type:
      - 'null'
      - string
    doc: Sort target genome
    inputBinding:
      position: 102
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
stdout: liftofftools_be.out
