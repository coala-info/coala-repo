cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - count
label: swga_count
doc: "Count k-mers in a foreground genome, then in a background genome, and add the results to the database\n\nTool homepage: https://github.com/eclarke/swga"
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
    doc: Minimum k-mer size
    inputBinding:
      position: 1
      prefix: --min_size
  - id: max_size
    type: ['null', int]
    doc: Maximum k-mer size
    inputBinding:
      position: 1
      prefix: --max_size
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
  - id: max_dimer_bp
    type: ['null', int]
    doc: Maximum number of consecutive complementary bases between a primer and its reverse complement
    inputBinding:
      position: 1
      prefix: --max_dimer_bp
  - id: exclude_threshold
    type: ['null', int]
    doc: Primers appearing this many times or more in the exclude file are excluded
    inputBinding:
      position: 1
      prefix: --exclude_threshold
  - id: input
    type: ['null', File]
    doc: A list of primers to add to the database by hand
    inputBinding:
      position: 1
      prefix: --input
  - id: force
    type: ['null', boolean]
    doc: Clear any previous primers without prompting
    inputBinding:
      position: 1
      prefix: --force
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
stdout: swga_count.stdout.txt
