cwlVersion: v1.2
class: CommandLineTool
baseCommand: WhatsGNU_main.py
label: whatsgnu_main
doc: "WhatsGNU ranks protein sequences by the number of exact protein matches (the
  GNU score) in all known genomes of a species. It writes a report for every protein
  in the query .faa file. Use either mkdatabase (build a compressed database from
  faa files) or database (use an existing compressed database).\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs:
  - id: query_faa
    type: File
    doc: Query protein FASTA file to analyze (.faa)
    inputBinding:
      position: 100
  - id: mkdatabase
    type:
      - 'null'
      - Directory
    doc: Folder of faa files to compress into a database
    inputBinding:
      position: 1
      prefix: --mkdatabase
      valueFrom: $(self.path + '/')
  - id: database
    type:
      - 'null'
      - File
    doc: Compressed database to use
    inputBinding:
      position: 1
      prefix: --database
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: Save database in pickle format [Default only txt file]
    inputBinding:
      position: 1
      prefix: --pickle
  - id: sql
    type:
      - 'null'
      - boolean
    doc: Save database in SQL format for large Databases [Default only txt file]
    inputBinding:
      position: 1
      prefix: --sql
  - id: roary_clustered_proteins
    type:
      - 'null'
      - File
    doc: clustered_proteins output file from roary to be used with --mkdatabase
    inputBinding:
      position: 1
      prefix: --roary_clustered_proteins
  - id: database_mode
    type:
      - 'null'
      - string
    doc: select a mode from 'ortholog' or 'basic' to be used with --database
    inputBinding:
      position: 1
      prefix: --database_mode
  - id: rarity_index
    type:
      - 'null'
      - float
    doc: ortholog variant rarity index (OVRI) cutoff value in range (0-1) [0.045]
      for ortholog mode
    inputBinding:
      position: 1
      prefix: --rarity_index
  - id: output_folder
    type: string
    doc: Output folder to be created for results
    inputBinding:
      position: 1
      prefix: --output_folder
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting existing results folder assigned with --output_folder
    inputBinding:
      position: 1
      prefix: --force
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output compressed database (default WhatsGNU_compressed_database)
    inputBinding:
      position: 1
      prefix: --prefix
  - id: topgenomes
    type:
      - 'null'
      - boolean
    doc: create a file of top N genomes with most number of exact matches to query
    inputBinding:
      position: 1
      prefix: --topgenomes
  - id: topgenomes_count
    type:
      - 'null'
      - int
    doc: select number of closest top genomes to show [Default top 10 genomes]
    inputBinding:
      position: 1
      prefix: --topgenomes_count
  - id: strainhits
    type:
      - 'null'
      - string
    doc: check how many hits you get from a particular strain, it has to be used
      with --topgenomes
    inputBinding:
      position: 1
      prefix: --strainhits
  - id: metadata
    type:
      - 'null'
      - File
    doc: metadata_frequency.csv file produced by the WhatsGNU customizer script,
      to get the metadata composition of your hits
    inputBinding:
      position: 1
      prefix: --metadata
  - id: ids_hits
    type:
      - 'null'
      - boolean
    doc: create a file of each protein with locus_tags (ids) of all hits from the
      database, large file
    inputBinding:
      position: 1
      prefix: --ids_hits
  - id: faa_gnu_0
    type:
      - 'null'
      - boolean
    doc: get a fasta (.faa) file of all proteins with GNU score of zero
    inputBinding:
      position: 1
      prefix: --faa_GNU_0
  - id: blastp
    type:
      - 'null'
      - boolean
    doc: run blastp on the proteins with GNU score of zero and modify the report
      with ortholog_info
    inputBinding:
      position: 1
      prefix: --blastp
  - id: output_blastp
    type:
      - 'null'
      - boolean
    doc: get the output report of blastp run, it has to be used with --blastp
    inputBinding:
      position: 1
      prefix: --output_blastp
  - id: percent_identity
    type:
      - 'null'
      - float
    doc: blastp percent identity cutoff value [80], range (0,100)
    inputBinding:
      position: 1
      prefix: --percent_identity
  - id: percent_coverage
    type:
      - 'null'
      - float
    doc: blastp percent coverage cutoff value [80], range (0,100)
    inputBinding:
      position: 1
      prefix: --percent_coverage
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 1
      prefix: --quiet
outputs:
  - id: results_folder
    type: Directory
    doc: Results folder with the GNU score report, log and (with mkdatabase) the compressed database
    outputBinding:
      glob: $(inputs.output_folder)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
