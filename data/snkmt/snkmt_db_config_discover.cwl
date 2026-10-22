cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - db
  - config
  - discover
label: snkmt_db_config_discover
doc: "Search for database files recursively and add them to configuration.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: "Directory to search for .db files (default: current directory)."
    inputBinding:
      position: 1
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
stdout: snkmt_db_config_discover.out
stderr: snkmt_db_config_discover.err
