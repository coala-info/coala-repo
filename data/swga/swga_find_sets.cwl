cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - find_sets
label: swga_find_sets
doc: "Find sets of compatible primers in a primer compatibility graph\n\nTool homepage: https://github.com/eclarke/swga"
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
  - id: min_size
    type: ['null', int]
    doc: Minimum size of primer sets
    inputBinding:
      position: 1
      prefix: --min_size
  - id: max_size
    type: ['null', int]
    doc: Maximum size of primer sets
    inputBinding:
      position: 1
      prefix: --max_size
  - id: max_dimer_bp
    type: ['null', int]
    doc: Maximum number of consecutive complementary bases between two primers
    inputBinding:
      position: 1
      prefix: --max_dimer_bp
  - id: min_bg_bind_dist
    type: ['null', int]
    doc: Minimum average distance between primers on the background genome
    inputBinding:
      position: 1
      prefix: --min_bg_bind_dist
  - id: max_fg_bind_dist
    type: ['null', int]
    doc: Maximum distance between primers on the foreground genome
    inputBinding:
      position: 1
      prefix: --max_fg_bind_dist
  - id: max_sets
    type: ['null', int]
    doc: Maximum number of sets to check (below zero finds as many as possible)
    inputBinding:
      position: 1
      prefix: --max_sets
  - id: reset
    type: ['null', boolean]
    doc: Remove all previously found sets
    inputBinding:
      position: 1
      prefix: --reset
  - id: workers
    type: ['null', int]
    doc: Number of workers to spawn
    inputBinding:
      position: 1
      prefix: --workers
  - id: force
    type: ['null', boolean]
    doc: Clear any previous sets without prompting
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
stdout: swga_find_sets.stdout.txt
