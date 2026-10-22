cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon
label: talon
doc: "TALON takes transcripts from one or more long read datasets (SAM format) and
  assigns them transcript and gene identifiers based on a database-bound annotation.
  Novel events are assigned new identifiers.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: config_file
    type: File
    doc: 'Dataset config file: dataset name, sample description, platform, sam file
      (comma-delimited)'
    inputBinding:
      position: 101
      prefix: --f
  - id: create_novel_spliced_genes
    type:
      - 'null'
      - boolean
    doc: Make novel genes with the intergenic novelty label for transcripts that
      don't share splice junctions with any other models
    inputBinding:
      position: 101
      prefix: --nsg
  - id: database
    type: File
    doc: TALON database. Created using talon_initialize_database (modified in place)
    inputBinding:
      position: 101
      prefix: --db
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM files named in the config file (staged next to it so the names resolve)
  - id: genome_build
    type: string
    doc: Genome build (i.e. hg38) to use. Must be in the database.
    inputBinding:
      position: 101
      prefix: --build
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum alignment coverage in order to use a SAM entry.
    inputBinding:
      position: 101
      prefix: --cov
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity in order to use a SAM entry.
    inputBinding:
      position: 101
      prefix: --identity
  - id: outprefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run program with.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Path to directory for tmp files.
    inputBinding:
      position: 101
      prefix: --tmpDir
  - id: use_cb_tag
    type:
      - 'null'
      - boolean
    doc: Use CB tag in input SAM file instead of including a dataset name in 
      your config file
    inputBinding:
      position: 101
      prefix: --cb
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity of TALON output. Higher numbers = more verbose.
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: updated_database
    type: File
    doc: TALON database, annotated in place
    outputBinding:
      glob: $(inputs.database.basename)
  - id: outprefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in outprefix
    outputBinding:
      glob: $(inputs.outprefix)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
      - $(inputs.sam_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon.out
