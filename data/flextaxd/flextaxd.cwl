cwlVersion: v1.2
class: CommandLineTool
baseCommand: flextaxd
label: flextaxd
doc: "FlexTaxD taxonomy sqlite3 database file (fullpath)\n\nTool homepage: https://github.com/FOI-Bioinformatics/flextaxd"
inputs:
  - id: clean_database
    type:
      - 'null'
      - boolean
    doc: Clean up database from unannotated nodes
    inputBinding:
      position: 101
      prefix: --clean_database
  - id: database
    type: File
    doc: FlexTaxD taxonomy sqlite3 database file (fullpath)
    inputBinding:
      position: 101
      prefix: --database
  - id: dbprogram
    type:
      - 'null'
      - string
    doc: Adjust output file to certain output specifications [kraken2, 
      krakenuniq, ganon, centrifuge, bracken]
    inputBinding:
      position: 101
      prefix: --dbprogram
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Write database to names.dmp and nodes.dmp
    inputBinding:
      position: 101
      prefix: --dump
  - id: dump_descriptions
    type:
      - 'null'
      - boolean
    doc: Dump description names instead of database integers
    inputBinding:
      position: 101
      prefix: --dump_descriptions
  - id: dump_genome_annotations
    type:
      - 'null'
      - boolean
    doc: Add genome taxid annotation to genomes dump
    inputBinding:
      position: 101
      prefix: --dump_genome_annotations
  - id: dump_genomes
    type:
      - 'null'
      - boolean
    doc: Print list of genomes (and source) to file
    inputBinding:
      position: 101
      prefix: --dump_genomes
  - id: dump_mini
    type:
      - 'null'
      - boolean
    doc: Dump minimal file with tab as separator
    inputBinding:
      position: 101
      prefix: --dump_mini
  - id: dump_prefix
    type:
      - 'null'
      - string
    doc: change dump prefix reqires two names default(names,nodes)
    inputBinding:
      position: 101
      prefix: --dump_prefix
  - id: dump_sep
    type:
      - 'null'
      - string
    doc: Set output separator default(NCBI) also adds extra trailing columns for
      kraken
    inputBinding:
      position: 101
      prefix: --dump_sep
  - id: force
    type:
      - 'null'
      - boolean
    doc: use when script is implemented in pipeline to avoid security questions 
      on overwrite!
    inputBinding:
      position: 101
      prefix: --force
  - id: genomeid2taxid
    type:
      - 'null'
      - File
    doc: File that lists which node a genome should be assigned to
    inputBinding:
      position: 101
      prefix: --genomeid2taxid
  - id: genomes_path
    type:
      - 'null'
      - Directory
    doc: Path to genome folder is required when using NCBI_taxonomy as source
    inputBinding:
      position: 101
      prefix: --genomes_path
  - id: logs
    type:
      - 'null'
      - Directory
    doc: Specify log directory
    inputBinding:
      position: 101
      prefix: --logs
  - id: mod_database
    type:
      - 'null'
      - File
    doc: Database file containing modifications
    inputBinding:
      position: 101
      prefix: --mod_database
  - id: mod_file
    type:
      - 'null'
      - File
    doc: File contaning modifications parent,child,(taxonomy level)
    inputBinding:
      position: 101
      prefix: --mod_file
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: parent
    type:
      - 'null'
      - string
    doc: Parent from which to add (replace see below) branch
    inputBinding:
      position: 101
      prefix: --parent
  - id: purge_database
    type:
      - 'null'
      - Directory
    doc: Used to purge the FlexTaxD-database from entries that lack a downloaded
      genome (such as when creating a GTDB-database using all taxonomy but using
      just the representative dataset) Provide the directory path of the 
      downloaded genomes (default = FALSE)
    inputBinding:
      position: 101
      prefix: --purge_database
  - id: purge_database_force
    type:
      - 'null'
      - boolean
    doc: If specified, will remove all genomes that are missing from the 
      FlexTaxD-database, regardless if they are distinct nodes or not in the 
      tree (default = FALSE)
    inputBinding:
      position: 101
      prefix: --purge_database_force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Dont show logging messages in terminal!
    inputBinding:
      position: 101
      prefix: --quiet
  - id: refdatabase
    type:
      - 'null'
      - string
    doc: For download command, give value of expected source, default (refseq)
    inputBinding:
      position: 101
      prefix: --refdatabase
  - id: rename_from
    type:
      - 'null'
      - string
    doc: Updates a node name. Must be paired with --rename_to
    inputBinding:
      position: 101
      prefix: --rename_from
  - id: rename_to
    type:
      - 'null'
      - string
    doc: Updates a node name. Must be paired with --rename_from
    inputBinding:
      position: 101
      prefix: --rename_to
  - id: replace
    type:
      - 'null'
      - boolean
    doc: Add if existing children of parents should be removed!
    inputBinding:
      position: 101
      prefix: --replace
  - id: skip_annotation
    type:
      - 'null'
      - boolean
    doc: Do not automatically add annotation when creating GTDB database
    inputBinding:
      position: 101
      prefix: --skip_annotation
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Print some statistics from the database
    inputBinding:
      position: 101
      prefix: --stats
  - id: supress
    type:
      - 'null'
      - boolean
    doc: Supress warnings
    inputBinding:
      position: 101
      prefix: --supress
  - id: taxid_base
    type:
      - 'null'
      - int
    doc: The base for internal taxonomy ID numbers, when using NCBI as base 
      select base at minimum 3000000 (default = 1)
    inputBinding:
      position: 101
      prefix: --taxid_base
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: Taxonomy source file
    inputBinding:
      position: 101
      prefix: --taxonomy_file
  - id: taxonomy_type
    type:
      - 'null'
      - string
    doc: Source format of taxonomy input file (CanSNPer,GTDB,NCBI,QIIME,SILVA)
    inputBinding:
      position: 101
      prefix: --taxonomy_type
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate database format
    inputBinding:
      position: 101
      prefix: --validate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vis_clip_labels
    type:
      - 'null'
      - boolean
    doc: If specified, will clip long node names in the drawn tree
    inputBinding:
      position: 101
      prefix: --vis_clip_labels
  - id: vis_depth
    type:
      - 'null'
      - int
    doc: Maximum depth from node to visualise default 3, 0 = all levels
    inputBinding:
      position: 101
      prefix: --vis_depth
  - id: vis_label_size
    type:
      - 'null'
      - string
    doc: Adjusts the size of labels printed at drawn tree nodes
    inputBinding:
      position: 101
      prefix: --vis_label_size
  - id: vis_node
    type:
      - 'null'
      - string
    doc: Visualise tree from selected node
    inputBinding:
      position: 101
      prefix: --vis_node
  - id: vis_type
    type:
      - 'null'
      - string
    doc: Choices [newick, newick_vis, tree]
    inputBinding:
      position: 101
      prefix: --vis_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flextaxd:0.4.4--pyhdfd78af_0
stdout: flextaxd.out
