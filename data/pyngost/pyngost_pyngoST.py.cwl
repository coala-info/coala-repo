cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyngoST
label: pyngost_pyngoST.py
doc: "fast, simultaneous and accurate multiple sequence typing of Neisseria gonorrhoeae
  genome collections\n\nTool homepage: https://github.com/leosanbu/pyngoST"
inputs:
  - id: alleles_out
    type:
      - 'null'
      - boolean
    doc: Print fasta files with new alleles
    default: false
    inputBinding:
      position: 101
      prefix: --alleles_out
  - id: blast_new_alleles
    type:
      - 'null'
      - boolean
    doc: Use blastn to find the closest alleles to new ones
    default: false
    inputBinding:
      position: 101
      prefix: --blast_new_alleles
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name of the folder that will contain the database in case a download is
      requested with -d
    default: allelesDB in working directory
    inputBinding:
      position: 101
      prefix: --db_name
  - id: download_db
    type:
      - 'null'
      - boolean
    doc: Download updated allele and profile files and create database
    inputBinding:
      position: 101
      prefix: --download_db
  - id: genogroups
    type:
      - 'null'
      - boolean
    doc: Calculate NG-MAST genogroups from NG-MAST types
    default: false
    inputBinding:
      position: 101
      prefix: --genogroups
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files (fasta or tab/csv)
    inputBinding:
      position: 101
      prefix: --input
  - id: mosaic_pena
    type:
      - 'null'
      - boolean
    doc: Report if the penA allele sequence is a mosaic or semimosaic
    default: false
    inputBinding:
      position: 101
      prefix: --mosaic_pena
  - id: ngstarccs
    type:
      - 'null'
      - boolean
    doc: Include NG-STAR CCs in output table
    default: false
    inputBinding:
      position: 101
      prefix: --ngstarccs
  - id: ngstarccsfile
    type:
      - 'null'
      - File
    doc: File with the NG-STAR clonal complexes (NG-STAR CCs) database (csv) to 
      integrate to NG-STAR profiles
    inputBinding:
      position: 101
      prefix: --ngstarccsfile
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of processes to use for computation
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: only_assignccs
    type:
      - 'null'
      - int
    doc: Only assign CCs from a table with NG-STAR STs. Indicate as value the 
      number of the column that contains the STs
    default: None
    inputBinding:
      position: 101
      prefix: --only_assignccs
  - id: only_assignsts
    type:
      - 'null'
      - boolean
    doc: Only assign STs from a table with NG-STAR, MLST and/or NG-MAST profiles
    default: None
    inputBinding:
      position: 101
      prefix: --only_assignsts
  - id: out_filename
    type:
      - 'null'
      - string
    doc: Name of file to print the results table to
    inputBinding:
      position: 101
      prefix: --out_filename
  - id: out_path
    type:
      - 'null'
      - Directory
    doc: Path used to save output files
    default: current directory
    inputBinding:
      position: 101
      prefix: --out_path
  - id: path
    type:
      - 'null'
      - Directory
    doc: Path to database containing MLST/NG-STAR alleles and profiles. If not 
      available, use -d to create an updated database
    inputBinding:
      position: 101
      prefix: --path
  - id: read_file
    type:
      - 'null'
      - File
    doc: File containing the paths to the input files
    inputBinding:
      position: 101
      prefix: --read_file
  - id: schemes
    type:
      - 'null'
      - string
    doc: 'Typing schemes to query separated by commas (options: NG-STAR, MLST, NG-MAST)'
    default: NG-STAR
    inputBinding:
      position: 101
      prefix: --schemes
  - id: update
    type:
      - 'null'
      - boolean
    doc: Only recreate the database pickle file
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0
stdout: pyngost_pyngoST.py.out
