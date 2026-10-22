cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - filter
label: swga_filter
doc: "Activate suitable primers in a database\n\nTool homepage: https://github.com/eclarke/swga"
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
    doc: List of primers (one per line) to activate, instead of pulling from the database
    inputBinding:
      position: 1
      prefix: --input
  - id: skip_filtering
    type: ['null', boolean]
    doc: Skip filtering and only mark the primers from --input as active
    inputBinding:
      position: 1
      prefix: --skip_filtering
  - id: max_primers
    type: ['null', int]
    doc: Maximum number of primers to keep after filtering
    inputBinding:
      position: 1
      prefix: --max_primers
  - id: min_fg_bind
    type: ['null', int]
    doc: Minimum number of primer binding sites on the foreground genome
    inputBinding:
      position: 1
      prefix: --min_fg_bind
  - id: max_bg_bind
    type: ['null', int]
    doc: Maximum primer binding sites on the background genome
    inputBinding:
      position: 1
      prefix: --max_bg_bind
  - id: min_tm
    type: ['null', float]
    doc: Minimum primer melting temperature (C)
    inputBinding:
      position: 1
      prefix: --min_tm
  - id: max_tm
    type: ['null', float]
    doc: Maximum primer melting temperature (C)
    inputBinding:
      position: 1
      prefix: --max_tm
  - id: max_gini
    type: ['null', float]
    doc: Maximum Gini coefficient for an individual primer on the foreground genome
    inputBinding:
      position: 1
      prefix: --max_gini
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
stdout: swga_filter.stdout.txt
