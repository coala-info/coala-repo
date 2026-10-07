cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm2
  - database
label: checkm2_database
doc: "Download/set up required diamond database for CheckM2.\n\nTool homepage: https://github.com/chklovski/CheckM2"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: lowmem
    type:
      - 'null'
      - boolean
    doc: Low memory mode. Reduces DIAMOND blocksize to significantly reduce RAM
      usage at the expense of longer runtime
    inputBinding:
      position: 101
      prefix: --lowmem
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download DIAMOND database. By default installs into [/root/databases]
    inputBinding:
      position: 101
      prefix: --download
  - id: setdblocation
    type:
      - 'null'
      - File
    doc: Point CheckM2 to the DIAMOND database location if already downloaded.
    inputBinding:
      position: 101
      prefix: --setdblocation
  - id: current
    type:
      - 'null'
      - boolean
    doc: Print where current database is installed.
    inputBinding:
      position: 101
      prefix: --current
  - id: download_path
    type:
      - 'null'
      - string
    doc: Custom path for downloading and installing database file.
    inputBinding:
      position: 101
      prefix: --path
  - id: no_write_json_db
    type:
      - 'null'
      - boolean
    doc: Do NOT attempt to write database path to internal JSON file [useful if
      install directory is not writable]
    inputBinding:
      position: 101
      prefix: --no_write_json_db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Folder with the downloaded database (CheckM2_database/uniref100.KO.1.dmnd).
    outputBinding:
      glob: $(inputs.download_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
stdout: checkm2_database.out
