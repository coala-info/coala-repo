cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virsorter
  - config
label: virsorter_config
doc: "CLI for managing configurations.\n\nTool homepage: https://github.com/simroux/VirSorter"
inputs:
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: directory for databases; required for --init-source
    inputBinding:
      position: 101
      prefix: --db-dir
  - id: get
    type:
      - 'null'
      - string
    doc: the value of a KEY (e.g. virsorter config --get 
      GROUP_INFO.RNA.MIN_GENOME_SIZE
    inputBinding:
      position: 101
      prefix: --get
  - id: init_source
    type:
      - 'null'
      - boolean
    doc: initialize configuration file
    inputBinding:
      position: 101
      prefix: --init-source
  - id: set
    type:
      - 'null'
      - string
    doc: 'set KEY to VAL with the format: KEY=VAL; for nested dict in YAML use KEY1.KEY2=VAL
      (e.g. virsorter config --set GROUP_INFO.RNA.MIN_GENOME_SIZE=2000)'
    inputBinding:
      position: 101
      prefix: --set
  - id: show
    type:
      - 'null'
      - boolean
    doc: show all configuration values
    inputBinding:
      position: 101
      prefix: --show
  - id: show_source
    type:
      - 'null'
      - boolean
    doc: show path of the configuration file
    inputBinding:
      position: 101
      prefix: --show-source
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_config.out
