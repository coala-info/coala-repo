cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools_and
doc: "liftofftools: error: argument subcommand: invalid choice: 'and' (choose from
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
    doc: Chain file for alignment
    inputBinding:
      position: 102
      prefix: -f
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output files
    inputBinding:
      position: 102
      prefix: -c
  - id: edit_distance
    type:
      - 'null'
      - boolean
    doc: Calculate edit distance
    inputBinding:
      position: 102
      prefix: --edit-distance
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing files
    inputBinding:
      position: 102
      prefix: --force
  - id: infer_genes
    type:
      - 'null'
      - boolean
    doc: Infer genes from alignments
    inputBinding:
      position: 102
      prefix: --infer-genes
  - id: mmseqs_params
    type:
      - 'null'
      - string
    doc: Parameters for MMseqs2
    inputBinding:
      position: 102
      prefix: --mmseqs_params
  - id: mmseqs_path
    type:
      - 'null'
      - File
    doc: Path to MMseqs2 executable
    inputBinding:
      position: 102
      prefix: --mmseqs_path
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: -dir
  - id: reference_genome
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_sort
    type:
      - 'null'
      - string
    doc: Sort order for reference genome
    inputBinding:
      position: 102
      prefix: -r-sort
  - id: target_genome_db
    type: File
    doc: Target genome GFF/GTF or DB file
    inputBinding:
      position: 102
      prefix: -t
  - id: target_genome_gff_gtf_or_db
    type: File
    doc: Target genome GFF/GTF or DB file
    inputBinding:
      position: 102
      prefix: -rg
  - id: target_genome_gff_gtf_or_db_2
    type: File
    doc: Target genome GFF/GTF or DB file
    inputBinding:
      position: 102
      prefix: -tg
  - id: target_sort
    type:
      - 'null'
      - string
    doc: Sort order for target genome
    inputBinding:
      position: 102
      prefix: -t-sort
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
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
stdout: liftofftools_and.out
