cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - db
  - config
  - add
label: snkmt_db_config_add
doc: "Add a database to the configuration file.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
  - id: database
    type: File
    doc: "Database file to add to the configuration."
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: "Display name for the database (default: filename stem)."
    inputBinding:
      position: 101
      prefix: --name
  - id: snkmt_data
    type:
      - 'null'
      - Directory
    doc: "Existing snkmt data folder (.local/share/snkmt with databases.json), staged into the home directory."
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of snkmt are written here)
  - id: config_dir
    type: Directory
    doc: The snkmt data folder holding databases.json after the command
    outputBinding:
      glob: .local/share/snkmt
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .local/share/snkmt
        entry: $(inputs.snkmt_data)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt_db_config_add.out
stderr: snkmt_db_config_add.err
