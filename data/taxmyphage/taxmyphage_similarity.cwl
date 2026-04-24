cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmyphage similarity
label: taxmyphage_similarity
doc: "Compares phage genomes and generates similarity reports.\n\nTool homepage: https://github.com/amillard/tax_myPHAGE"
inputs:
  - id: blastn_executable
    type:
      - 'null'
      - string
    doc: Path to the blastn executable
    inputBinding:
      position: 101
      prefix: --blastn
  - id: database_folder
    type:
      - 'null'
      - Directory
    doc: Path to the database directory where the databases are stored.
    inputBinding:
      position: 101
      prefix: --db_folder
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrites the genome output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to an input fasta file(s), or directory containing fasta files. 
      The fasta file(s) could contain multiple phage genomes. They can be 
      compressed (gzip). If a directory is given the expected fasta extentions 
      are ['fasta', 'fna', 'fsa', 'fa'] but can be gzipped.
    inputBinding:
      position: 101
      prefix: --input
  - id: makeblastdb_executable
    type:
      - 'null'
      - string
    doc: Path to the blastn executable
    inputBinding:
      position: 101
      prefix: --makeblastdb
  - id: no_figures
    type:
      - 'null'
      - boolean
    doc: Use this option if you don't want to generate Figures. This will speed 
      up the time it takes to run the script - but you get no Figures. (By 
      default, Figures are generated)
    inputBinding:
      position: 101
      prefix: --no-figures
  - id: no_precomputed
    type:
      - 'null'
      - boolean
    doc: Don't use the precomputed blastn matrix
    inputBinding:
      position: 101
      prefix: --no-precomputed
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to the output directory.
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Will add the prefix to results and summary files that will store 
      results of MASH and comparision to the VMR Data produced by ICTV combines 
      both sets of this data into a single csv file. Use this flag if you want 
      to run multiple times and keep the results files without manual renaming 
      of files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the reference database file. Input file will be used as query 
      against it. If not provided, input will be compare against itself. If you 
      use reference no figure is generated.
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads that will be used by BLASTn.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
stdout: taxmyphage_similarity.out
