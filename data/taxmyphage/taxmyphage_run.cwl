cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmyphage run
label: taxmyphage_run
doc: "Run taxmyphage analysis\n\nTool homepage: https://github.com/amillard/tax_myPHAGE"
inputs:
  - id: input_fasta_files
    type:
      type: array
      items: File
    doc: Path to an input fasta file(s), or directory containing fasta files. 
      The fasta file(s) could contain multiple phage genomes. They can be 
      compressed (gzip). If a directory is given the expected fasta extentions 
      are ['fasta', 'fna', 'fsa', 'fa'] but can be gzipped.
    inputBinding:
      position: 1
  - id: blastdbcmd_executable
    type:
      - 'null'
      - string
    doc: Path to the blastn executable
    inputBinding:
      position: 102
      prefix: --blastdbcmd
  - id: blastn_executable
    type:
      - 'null'
      - string
    doc: Path to the blastn executable
    inputBinding:
      position: 102
      prefix: --blastn
  - id: database_folder
    type:
      - 'null'
      - Directory
    doc: Path to the database directory where the databases are stored.
    inputBinding:
      position: 102
      prefix: --db_folder
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites the genome output directory
    inputBinding:
      position: 102
      prefix: --force
  - id: generate_figures
    type:
      - 'null'
      - boolean
    doc: Use this option if you don't want to generate Figures. This will speed 
      up the time it takes to run the script - but you get no Figures. (By 
      default, Figures are generated)
    inputBinding:
      position: 102
      prefix: --no-figures
  - id: makeblastdb_executable
    type:
      - 'null'
      - string
    doc: Path to the blastn executable
    inputBinding:
      position: 102
      prefix: --makeblastdb
  - id: mash_distance
    type:
      - 'null'
      - float
    doc: Will change the mash distance for the intial seraching for close 
      relatives. We suggesting keeping at 0.2 If this results in the phage not 
      being classified, then increasing to 0.3 might result in an output that 
      shows the phage is a new genus. We have found increasing above 0.2 does 
      not place the query in any current genus, only provides the output files 
      to demonstrate it falls outside of current genera.
    inputBinding:
      position: 102
      prefix: --distance
  - id: mash_executable
    type:
      - 'null'
      - string
    doc: Path to the MASH executable
    inputBinding:
      position: 102
      prefix: --mash
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to the output directory.
    inputBinding:
      position: 102
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
      position: 102
      prefix: --prefix
  - id: reference_database
    type:
      - 'null'
      - File
    doc: Path to the reference database file. Input file will be used as query 
      against it. If not provided, input will be compare against itself. If you 
      use reference no figure is generated.
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads that will be used by BLASTn.
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_precomputed
    type:
      - 'null'
      - boolean
    doc: Don't use the precomputed blastn matrix
    inputBinding:
      position: 102
      prefix: --no-precomputed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output. (For debugging purposes)
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
stdout: taxmyphage_run.out
