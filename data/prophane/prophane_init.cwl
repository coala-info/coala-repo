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
    type: string
    doc: Path for storing prophane databases (created in the working directory)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: general_config
    type: File
    doc: General config file written by init ($HOME/.config/prophane.yaml)
    outputBinding:
      glob: .config/prophane.yaml
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.db_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
      - entryname: .config
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_init.out
