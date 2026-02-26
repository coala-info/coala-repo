cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin write_pangenome
label: ppanggolin_write_pangenome
doc: "Write pangenome data to various formats.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: borders
    type:
      - 'null'
      - boolean
    doc: List all borders of each spot
    inputBinding:
      position: 101
      prefix: --borders
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output files using gzip (.gz)
    inputBinding:
      position: 101
      prefix: --compress
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Export gene presence/absence in CSV format (compatible with Roary). 
      Uses partitions as alternative gene IDs if available.
    inputBinding:
      position: 101
      prefix: --csv
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: Minimum ratio of genomes in which the family must have multiple genes 
      for it to be considered 'duplicated'
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: families_tsv
    type:
      - 'null'
      - boolean
    doc: Write a TSV file mapping genes to their corresponding gene families
    inputBinding:
      position: 101
      prefix: --families_tsv
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: gexf
    type:
      - 'null'
      - boolean
    doc: Generate a detailed GEXF file with all genes and annotations for each 
      family
    inputBinding:
      position: 101
      prefix: --gexf
  - id: json
    type:
      - 'null'
      - boolean
    doc: Export the graph in JSON file format
    inputBinding:
      position: 101
      prefix: --json
  - id: light_gexf
    type:
      - 'null'
      - boolean
    doc: Generate a simplified GEXF file with basic gene family information
    inputBinding:
      position: 101
      prefix: --light_gexf
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: modules
    type:
      - 'null'
      - boolean
    doc: Write a TSV file listing functional modules and their associated gene 
      families
    inputBinding:
      position: 101
      prefix: --modules
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: partitions
    type:
      - 'null'
      - boolean
    doc: Generate one file per partition listing the gene families it contains
    inputBinding:
      position: 101
      prefix: --partitions
  - id: regions
    type:
      - 'null'
      - boolean
    doc: Write predicted RGPs (Regions of Genomic Plasticity) and metrics to 
      'plastic_regions.tsv'
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_families
    type:
      - 'null'
      - boolean
    doc: Write a TSV file mapping each RGP to its gene family content in 
      'rgp_families.tsv'
    inputBinding:
      position: 101
      prefix: --regions_families
  - id: rtab
    type:
      - 'null'
      - boolean
    doc: Export gene presence/absence as a tabular binary matrix
    inputBinding:
      position: 101
      prefix: --Rtab
  - id: soft_core
    type:
      - 'null'
      - float
    doc: Soft core threshold to use
    inputBinding:
      position: 101
      prefix: --soft_core
  - id: spot_modules
    type:
      - 'null'
      - boolean
    doc: Generate two files comparing module presence across spots
    inputBinding:
      position: 101
      prefix: --spot_modules
  - id: spots
    type:
      - 'null'
      - boolean
    doc: Write spot summary and list all RGPs (Regions of Genomic Plasticity) 
      per spot
    inputBinding:
      position: 101
      prefix: --spots
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Generate genome statistics ('genome_statistics.tsv') and duplication 
      summary of persistent families ('mean_persistent_duplication.tsv')
    inputBinding:
      position: 101
      prefix: --stats
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
