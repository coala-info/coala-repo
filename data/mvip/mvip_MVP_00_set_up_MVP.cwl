cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip_MVP_00_set_up_MVP
label: mvip_MVP_00_set_up_MVP
doc: "Check for any potential errors/issues in the metadata and the sequencing/read
  files, create all the directories that MVP needs, and install the latest versions
  of geNomad and checkV databases.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: checkv_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory where CheckV database will be installed.
    inputBinding:
      position: 101
      prefix: --checkv_db_path
  - id: genomad_db_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory where geNomad database will be installed.
    inputBinding:
      position: 101
      prefix: --genomad_db_path
  - id: metadata_path
    type: File
    doc: Path to the metadata that will be use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: skip_check_errors
    type:
      - 'null'
      - boolean
    doc: Skip to run sequence data error checking.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_check_errors
  - id: skip_install_databases
    type:
      - 'null'
      - boolean
    doc: Install geNomad and CheckV databases in the respective repositories.
    default: false
    inputBinding:
      position: 101
      prefix: --skip_install_databases
  - id: working_directory_path
    type: Directory
    doc: Path to the working directory where MVP will be run.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_00_set_up_MVP.out
