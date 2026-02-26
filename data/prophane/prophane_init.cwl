cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophane
  - init
label: prophane_init
doc: "Write DB_DIR path for storing prophane databases to general config file.\n\n\
  Tool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs:
  - id: db_dir
    type: Directory
    doc: Path for storing prophane databases
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_init.out
