cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie init
label: refgenie_init
doc: "Initialize a genome configuration.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: genome_archive_config
    type:
      - 'null'
      - File
    doc: Absolute path to desired archive config file; used by refgenieserver.
    inputBinding:
      position: 101
      prefix: --genome-archive-config
  - id: genome_archive_folder
    type:
      - 'null'
      - Directory
    doc: Absolute path to parent archive folder refgenie-managed assets; used by
      refgenieserver.
    inputBinding:
      position: 101
      prefix: --genome-archive-folder
  - id: genome_config
    type: string
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 101
      prefix: --genome-config
  - id: genome_folder
    type:
      - 'null'
      - Directory
    doc: Absolute path to parent folder refgenie-managed assets.
    inputBinding:
      position: 101
      prefix: --genome-folder
  - id: genome_server
    type:
      - 'null'
      - type: array
        items: string
    doc: URL(s) to use for the genome_servers attribute in config file.
    inputBinding:
      position: 101
      prefix: --genome-server
  - id: remote_url_base
    type:
      - 'null'
      - string
    doc: URL to use as an alternative, remote archive location; used by 
      refgenieserver.
    inputBinding:
      position: 101
      prefix: --remote-url-base
  - id: settings_json
    type:
      - 'null'
      - File
    doc: Absolute path to a JSON file with the key value pairs to inialize the 
      configuration file with. Overwritten by itemized specifications.
    inputBinding:
      position: 101
      prefix: --settings-json
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 101
      prefix: --skip-read-lock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_init.out
