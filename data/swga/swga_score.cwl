cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - score
label: swga_score
doc: "Score a set of primers\n\nTool homepage: https://github.com/eclarke/swga"
inputs:
  - id: fg_genome
    type: File
    doc: Foreground genome FASTA given to swga init (staged as fg.fa)
  - id: bg_genome
    type: File
    doc: Background genome FASTA given to swga init (staged as bg.fa)
  - id: exclude_genome
    type: File
    doc: Exclusion FASTA given to swga init (staged as ex.fa)
  - id: workspace_db
    type: File
    doc: swga workspace database (swga.db) made by swga init
  - id: parameters_cfg
    type: File
    doc: swga parameters file (parameters.cfg) made by swga init
  - id: input
    type: ['null', File]
    doc: A file with a list of primers to score, one per line
    inputBinding:
      position: 1
      prefix: --input
  - id: force
    type: ['null', boolean]
    doc: Do not prompt for confirmation before adding a set by hand
    inputBinding:
      position: 1
      prefix: --force
  - id: score_expression
    type: ['null', string]
    doc: Python expression for the set score; may use set_size, fg_dist_mean, fg_dist_std, fg_dist_gini, fg_dist_max, bg_dist_mean
    inputBinding:
      position: 1
      prefix: --score_expression
outputs:
  - id: workspace_db_out
    type: File
    doc: Updated swga workspace database
    outputBinding:
      glob: swga.db
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: swga.db
        entry: $(inputs.workspace_db)
        writable: true
      - entryname: fg.fa
        entry: $(inputs.fg_genome)
        writable: true
      - entryname: bg.fa
        entry: $(inputs.bg_genome)
        writable: true
      - entryname: ex.fa
        entry: $(inputs.exclude_genome)
        writable: true
      - entryname: parameters.cfg
        entry: $(inputs.parameters_cfg)
        writable: true
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
    dockerOutputDirectory: /swga_work
stdout: swga_score.stdout.txt
