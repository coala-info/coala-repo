cwlVersion: v1.2
class: CommandLineTool
baseCommand: zdb_setup
label: zdb_setup
doc: "Downloads and sets up the reference database used by the analysis pipeline,
  as well as the zDB base database.\n\nTool homepage: https://github.com/metagenlab/zDB/"
inputs:
  - id: cog
    type:
      - 'null'
      - boolean
    doc: downloads the CDD profiles used for COG annotations
    inputBinding:
      position: 101
      prefix: --cog
  - id: conda
    type:
      - 'null'
      - boolean
    doc: uses conda environment to prepare the databases
    inputBinding:
      position: 101
      prefix: --conda
  - id: dir
    type:
      - 'null'
      - Directory
    doc: directory where to store the reference databases
    default: zdb_ref in the current directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: docker
    type:
      - 'null'
      - boolean
    doc: uses docker containers to prepare the databases
    inputBinding:
      position: 101
      prefix: --docker
  - id: ko
    type:
      - 'null'
      - boolean
    doc: downloads and setups the hmm profiles of the ko database
    inputBinding:
      position: 101
      prefix: --ko
  - id: pfam
    type:
      - 'null'
      - boolean
    doc: downloads and setups up the hmm profiles of the PFAM protein domains
    inputBinding:
      position: 101
      prefix: --pfam
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: downloads and indexes the NR RefSeq database
    inputBinding:
      position: 101
      prefix: --refseq
  - id: resume
    type:
      - 'null'
      - boolean
    doc: resume a previously failed execution
    inputBinding:
      position: 101
      prefix: --resume
  - id: setup_base_db
    type:
      - 'null'
      - boolean
    doc: set up the DB skeleton used by zDB. Has to be done before running "zdb 
      run" for the first time.
    inputBinding:
      position: 101
      prefix: --setup_base_db
  - id: singularity_dir
    type:
      - 'null'
      - Directory
    doc: the directory where the singularity images are downloaded
    default: singularity in current directory
    inputBinding:
      position: 101
      prefix: --singularity_dir
  - id: swissprot
    type:
      - 'null'
      - boolean
    doc: downloads and indexes the swissprot database
    inputBinding:
      position: 101
      prefix: --swissprot
  - id: vfdb
    type:
      - 'null'
      - boolean
    doc: downloads the virulence factor database
    inputBinding:
      position: 101
      prefix: --vfdb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zdb:1.3.11--hdfd78af_0
stdout: zdb_setup.out
