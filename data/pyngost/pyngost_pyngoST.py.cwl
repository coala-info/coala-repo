cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyngoST.py
label: pyngost_pyngoST.py
doc: "fast, simultaneous and accurate multiple sequence typing of Neisseria gonorrhoeae
  genome collections\n\nTool homepage: https://github.com/leosanbu/pyngoST"
inputs:
  - id: alleles_out
    type:
      - 'null'
      - boolean
    doc: Print fasta files with new alleles
    inputBinding:
      position: 101
      prefix: --alleles_out
  - id: blast_new_alleles
    type:
      - 'null'
      - boolean
    doc: Use blastn to find the closest alleles to new ones
    inputBinding:
      position: 101
      prefix: --blast_new_alleles
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name of the folder that will contain the database in case a download is
      requested with -d
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
    inputBinding:
      position: 101
      prefix: --mosaic_pena
  - id: ngstarccs
    type:
      - 'null'
      - boolean
    doc: Include NG-STAR CCs in output table
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
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: only_assignccs
    type:
      - 'null'
      - int
    doc: Only assign CCs from a table with NG-STAR STs. Indicate as value the 
      number of the column that contains the STs
    inputBinding:
      position: 101
      prefix: --only_assignccs
  - id: only_assignsts
    type:
      - 'null'
      - boolean
    doc: Only assign STs from a table with NG-STAR, MLST and/or NG-MAST profiles
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
      - string
    doc: Path used to save output files
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
    doc: Typing table (screen output when no output file name is given)
  - id: results_table
    type:
      - 'null'
      - File
    doc: Results table written with out_filename
    outputBinding:
      glob: "$(inputs.out_filename ? (inputs.out_path ? inputs.out_path + '/' + inputs.out_filename : inputs.out_filename) : null)"
  - id: new_allele_fastas
    type:
      type: array
      items: File
    doc: Fasta files with new alleles (alleles_out option)
    outputBinding:
      glob: "$(inputs.out_path ? inputs.out_path : '.')/*.fasta"
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Downloaded allele and profile database (download_db option)
    outputBinding:
      glob: "$(inputs.download_db ? (inputs.db_name ? inputs.db_name : 'allelesDB') : null)"
  - id: updated_database
    type:
      - 'null'
      - Directory
    doc: Database directory with the recreated pickle file (update option)
    outputBinding:
      glob: "$(inputs.update && inputs.path ? inputs.path.basename : null)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.update && inputs.path) {
          l.push({"entry": inputs.path, "writable": true});
        }
        if (inputs.out_path) {
          l.push({"entryname": inputs.out_path, "writable": true,
                  "entry": {"class": "Directory", "basename": inputs.out_path, "listing": []}});
        }
        return l;
      }
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0
stdout: pyngost_pyngoST.py.out
