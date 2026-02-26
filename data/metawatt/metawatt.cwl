cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar MetaWatt-3.5.3
label: metawatt
doc: "Metawatt version 3.5.3\n\nTool homepage: https://github.com/edhelas/metawatt"
inputs:
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: check dependencies and exit
    inputBinding:
      position: 101
      prefix: --check-dependencies
  - id: cov_rel_weight
    type:
      - 'null'
      - float
    doc: relative weight of differential coverage scores versus tetranucleotide 
      scores
    inputBinding:
      position: 101
      prefix: --cov-rel-weight
  - id: explore
    type:
      - 'null'
      - Directory
    doc: opens graphical user interface to explore pipeline results
    inputBinding:
      position: 101
      prefix: --explore
  - id: run
    type:
      - 'null'
      - Directory
    doc: runs metawatt pipeline on the command line
    inputBinding:
      position: 101
      prefix: --run
  - id: skip_database_update
    type:
      - 'null'
      - boolean
    doc: do not update databases
    inputBinding:
      position: 101
      prefix: --skip-database-update
  - id: temp_folder
    type:
      - 'null'
      - Directory
    doc: temp folder used
    inputBinding:
      position: 101
      prefix: --temp-folder
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads/processors
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawatt:3.5.3--boost1.64_0
stdout: metawatt.out
