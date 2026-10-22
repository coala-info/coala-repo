cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - db
  - config
  - list
label: snkmt_db_config_list
doc: "List all configured databases.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
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
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .local/share/snkmt
        entry: $(inputs.snkmt_data)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt_db_config_list.out
stderr: snkmt_db_config_list.err
