cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - create_db
label: tb-profiler_create_db
doc: "Create a new mutation database (a library) for tb-profiler\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: prefix
    type: string
    doc: 'The prefix for all output files (the new database directory)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: csv
    type:
      - 'null'
      - type: array
        items: File
    doc: 'The input CSV file(s) containing the mutations (default: mutations.csv)'
    inputBinding:
      position: 101
      prefix: --csv
      valueFrom: ${return self.map(function(f){return f.basename;});}
  - id: watchlist
    type:
      - 'null'
      - File
    doc: 'A csv file containing genes to profile but without any specific associated mutations (default: watchlist.csv)'
    inputBinding:
      position: 101
      prefix: --watchlist
      valueFrom: $(self.basename)
  - id: spoligotypes
    type:
      - 'null'
      - File
    doc: 'A file containing a list of spoligotype spacers (default: spoligotype_spacers.txt)'
    inputBinding:
      position: 101
      prefix: --spoligotypes
      valueFrom: $(self.basename)
  - id: spoligotype_annotations
    type:
      - 'null'
      - File
    doc: 'Spoligotype annotation file'
    inputBinding:
      position: 101
      prefix: --spoligotype_annotations
      valueFrom: $(self.basename)
  - id: barcode
    type:
      - 'null'
      - File
    doc: 'A bed file containing lineage barcode SNPs (default: barcode.bed)'
    inputBinding:
      position: 101
      prefix: --barcode
      valueFrom: $(self.basename)
  - id: bedmask
    type:
      - 'null'
      - File
    doc: 'A bed file containing a list of low-complexity regions (default: mask.bed)'
    inputBinding:
      position: 101
      prefix: --bedmask
      valueFrom: $(self.basename)
  - id: rules
    type:
      - 'null'
      - File
    doc: 'A yaml file containing rules for the resistance library (default: rules.yml)'
    inputBinding:
      position: 101
      prefix: --rules
      valueFrom: $(self.basename)
  - id: amplicon_primers
    type:
      - 'null'
      - File
    doc: 'A file containing a list of amplicon primers'
    inputBinding:
      position: 101
      prefix: --amplicon_primers
      valueFrom: $(self.basename)
  - id: match_ref
    type:
      - 'null'
      - File
    doc: 'Match the chromosome name to the given fasta file'
    inputBinding:
      position: 101
      prefix: --match_ref
      valueFrom: $(self.basename)
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: 'Create a samtools, gatk and bwa index for the reference genome'
    inputBinding:
      position: 101
      prefix: --create_index
  - id: custom
    type:
      - 'null'
      - boolean
    doc: 'Tells the script this is a custom database, this is used to alter the generation of the version definition'
    inputBinding:
      position: 101
      prefix: --custom
  - id: db_name
    type:
      - 'null'
      - string
    doc: 'Overrides the name of the database in the version file'
    inputBinding:
      position: 101
      prefix: --db_name
  - id: db_commit
    type:
      - 'null'
      - string
    doc: 'Overrides the commit string of the database in the version file'
    inputBinding:
      position: 101
      prefix: --db_commit
  - id: db_author
    type:
      - 'null'
      - string
    doc: 'Overrides the author of the database in the version file'
    inputBinding:
      position: 101
      prefix: --db_author
  - id: db_date
    type:
      - 'null'
      - string
    doc: 'Overrides the date of the database in the version file'
    inputBinding:
      position: 101
      prefix: --db_date
  - id: include_original_mutation
    type:
      - 'null'
      - boolean
    doc: 'Include the original mutation (before reformatting) as part of the variant annotation'
    inputBinding:
      position: 101
      prefix: --include_original_mutation
  - id: load
    type:
      - 'null'
      - boolean
    doc: 'Automatically load database'
    inputBinding:
      position: 101
      prefix: --load
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: 'Do not load if existing database with prefix exists'
    inputBinding:
      position: 101
      prefix: --no_overwrite
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwrite existing database with the same name'
    inputBinding:
      position: 101
      prefix: --force
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory (default: .)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: db_dir
    type:
      - 'null'
      - string
    doc: 'Database directory used when loading (default: /usr/local/share/tbprofiler in the image, which is read-only)'
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: genome_fasta
    type: File
    doc: 'Reference genome (staged as genome.fasta, read by create_db from the working directory)'
  - id: genome_gff
    type: File
    doc: 'Genome annotation (staged as genome.gff, read by create_db from the working directory)'
  - id: snpeff_predictor
    type: File
    doc: 'snpEff predictor file (staged as snpEffectPredictor.bin, read by create_db from the working directory)'
  - id: variables_json
    type: File
    doc: 'Database variables file (staged as variables.json, read by create_db from the working directory)'
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL (default: INFO)'
    inputBinding:
      position: 101
      prefix: --logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: db_library_dir
    type:
      - 'null'
      - Directory
    doc: 'The new database directory'
    outputBinding:
      glob: $(inputs.prefix)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: genome.fasta
        entry: $(inputs.genome_fasta)
      - entryname: genome.gff
        entry: $(inputs.genome_gff)
      - entryname: snpEffectPredictor.bin
        entry: $(inputs.snpeff_predictor)
      - entryname: variables.json
        entry: $(inputs.variables_json)
      - $(inputs.csv)
      - $(inputs.watchlist)
      - $(inputs.spoligotypes)
      - $(inputs.spoligotype_annotations)
      - $(inputs.barcode)
      - $(inputs.bedmask)
      - $(inputs.rules)
      - $(inputs.amplicon_primers)
      - $(inputs.match_ref)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_create_db.out
