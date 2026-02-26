cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv update_database
label: checkv_update_database
doc: "Update CheckV's database with your own complete genomes\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: source_db
    type: Directory
    doc: Path to current CheckV database.
    inputBinding:
      position: 1
  - id: dest_db
    type: Directory
    doc: Path to updated CheckV database.
    inputBinding:
      position: 2
  - id: genomes
    type: File
    doc: FASTA file of complete genomes to add to database, where each 
      nucleotide sequence represents one genome.
    inputBinding:
      position: 3
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 104
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing database
    inputBinding:
      position: 104
      prefix: --restart
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for prodigal-gv and DIAMOND
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
stdout: checkv_update_database.out
