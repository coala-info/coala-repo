cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenie
  - populater
label: refgenie_populater
doc: "Populate registry paths with remote paths.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: append_server
    type:
      - 'null'
      - boolean
    doc: Whether the provided servers should be appended to the list.
    inputBinding:
      position: 101
      prefix: --append-server
  - id: file
    type:
      - 'null'
      - File
    doc: File with registry paths to populate
    inputBinding:
      position: 101
      prefix: --file
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 101
      prefix: --genome-config
  - id: genome_server
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more URLs to use. This information will not persist in the 
      genome config file.
    inputBinding:
      position: 101
      prefix: --genome-server
  - id: remote_class
    type:
      - 'null'
      - string
    doc: Remote data provider class, e.g. 'http' or 's3'
    inputBinding:
      position: 101
      prefix: --remote-class
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
stdout: refgenie_populater.out
