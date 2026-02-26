cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftofftools
label: liftofftools_mmseqs
doc: "liftofftools: error: argument subcommand: invalid choice: 'mmseqs' (choose from
  'clusters', 'variants', 'synteny', 'all')\n\nTool homepage: https://github.com/agshumate/LiftoffTools"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (clusters, variants, synteny, all)
    inputBinding:
      position: 1
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output
    inputBinding:
      position: 102
      prefix: -c
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory for intermediate files
    inputBinding:
      position: 102
      prefix: --dir
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
    doc: Infer genes
    inputBinding:
      position: 102
      prefix: --infer-genes
  - id: mmseqs_params
    type:
      - 'null'
      - string
    doc: Parameters to pass to mmseqs
    inputBinding:
      position: 102
      prefix: --mmseqs_params
  - id: mmseqs_path
    type:
      - 'null'
      - string
    doc: Path to mmseqs executable
    inputBinding:
      position: 102
      prefix: --mmseqs_path
  - id: reference_genome
    type: string
    doc: Reference genome
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_genome_gff_gtf_or_db
    type: string
    doc: Target genome (GFF/GTF or DB)
    inputBinding:
      position: 102
      prefix: -tg
  - id: reference_sort
    type:
      - 'null'
      - string
    doc: Sort reference genome by this key
    inputBinding:
      position: 102
      prefix: --r-sort
  - id: target_genome
    type: string
    doc: Target genome (GFF/GTF or DB)
    inputBinding:
      position: 102
      prefix: -t
  - id: target_genome_gff_gtf_or_db
    type: string
    doc: Target genome (GFF/GTF or DB)
    inputBinding:
      position: 102
      prefix: -rg
  - id: target_sort
    type:
      - 'null'
      - string
    doc: Sort target genome by this key
    inputBinding:
      position: 102
      prefix: --t-sort
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
