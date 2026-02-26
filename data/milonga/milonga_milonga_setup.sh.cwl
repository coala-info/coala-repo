cwlVersion: v1.2
class: CommandLineTool
baseCommand: bash /usr/local/opt/milonga/scripts/milonga_setup.sh
label: milonga_milonga_setup.sh
doc: "This script completes the installation of the MiLongA pipeline. The openssl
  library is required for hashing the downloaded files.\nfor MiLongA installations
  from Gitlab use the option set [--mamba --databases].\nFor more information, please
  visit https://gitlab.com/bfr_bioinformatics/milonga\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/milonga"
inputs:
  - id: databases
    type:
      - 'null'
      - boolean
    doc: Download databases to <MiLongA>/download and extract them in 
      <MiLongA>/databases
    inputBinding:
      position: 101
      prefix: --databases
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite for downloads in <MiLongA>/download
    inputBinding:
      position: 101
      prefix: --force
  - id: keep_downloads
    type:
      - 'null'
      - boolean
    doc: Do not remove downloads after extraction
    inputBinding:
      position: 101
      prefix: --keep_downloads
  - id: mamba
    type:
      - 'null'
      - boolean
    doc: "Install the latest version of 'mamba' to the Conda base environment and\n\
      create the MiLongA environment from the git repository recipe"
    inputBinding:
      position: 101
      prefix: --mamba
  - id: status
    type:
      - 'null'
      - boolean
    doc: Show installation status
    inputBinding:
      position: 101
      prefix: --status
  - id: test_data
    type:
      - 'null'
      - boolean
    doc: Download test data to <MiLongA>/download and extract them in 
      <MiLongA>/test_data
    inputBinding:
      position: 101
      prefix: --test_data
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print script debug info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/milonga:1.0.3--hdfd78af_0
stdout: milonga_milonga_setup.sh.out
