cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_organelle_config.py
label: getorganelle_get_organelle_config.py
doc: "is used for setting up default GetOrganelle database.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: add_organelle_type
    type:
      - 'null'
      - string
    doc: Add database for organelle type(s). Followed by any of 
      all/embplant_pt/embplant_mt/embplant_nr/fungus_mt/fungus_nr/animal_mt/other_pt
      or multiple types joined by comma such as 
      embplant_pt,embplant_mt,fungus_mt.
    inputBinding:
      position: 101
      prefix: --add
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check configured database files and exit.
    inputBinding:
      position: 101
      prefix: --check
  - id: clean
    type:
      - 'null'
      - boolean
    doc: Remove all configured database files (=="--rm all").
    inputBinding:
      position: 101
      prefix: --clean
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: The directory where the default databases were placed. The default 
      value also can be changed by adding 'export GETORG_PATH=your_favor' to the
      shell script (e.g. ~/.bash_profile or ~/.bashrc)
    default: /root/.GetOrganelle
    inputBinding:
      position: 101
      prefix: --config-dir
  - id: db_type
    type:
      - 'null'
      - string
    doc: The database type (seed/label/both).
    default: both
    inputBinding:
      position: 101
      prefix: --db-type
  - id: db_version
    type:
      - 'null'
      - string
    doc: The version of database to add. Find more versions at 
      github.com/Kinggerm/GetOrganelleDB.
    default: latest
    inputBinding:
      position: 101
      prefix: --use-version
  - id: list
    type:
      - 'null'
      - boolean
    doc: List configured databases checking and exit.
    inputBinding:
      position: 101
      prefix: --list
  - id: rm_organelle_type
    type:
      - 'null'
      - string
    doc: Remove local database(s) for organelle type(s). Followed by any of 
      all/embplant_pt/embplant_mt/embplant_nr/fungus_mt/fungus_nr/animal_mt/other_pt
      or multiple types joined by comma such as embplant_pt,embplant_mt.
    inputBinding:
      position: 101
      prefix: --rm
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update local databases to the latest online version, or the local 
      version if "--use-local LOCAL_DB_PATH" provided.
    inputBinding:
      position: 101
      prefix: --update
  - id: use_local
    type:
      - 'null'
      - Directory
    doc: Input a path. This local database path must include subdirectories 
      LabelDatabase and SeedDatabase, under which there is the fasta file(s) 
      named by the organelle type you want add, such as fungus_mt.fasta.
    inputBinding:
      position: 101
      prefix: --use-local
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output to the screen.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: which_blast
    type:
      - 'null'
      - File
    doc: 'Assign the path to BLAST binary files if not added to the path. Default:
      try "/GetOrganelleDep/linux/ncbi-blast" first, then $PATH'
    inputBinding:
      position: 101
      prefix: --which-blast
  - id: which_bowtie2
    type:
      - 'null'
      - File
    doc: 'Assign the path to Bowtie2 binary files if not added to the path. Default:
      try "/GetOrganelleDep/linux/bowtie2" first, then $PATH'
    inputBinding:
      position: 101
      prefix: --which-bowtie2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_get_organelle_config.py.out
