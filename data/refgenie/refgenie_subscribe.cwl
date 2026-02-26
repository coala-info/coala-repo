cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie subscribe
label: refgenie_subscribe
doc: "Add a refgenieserver URL to the config.\n\nTool homepage: http://refgenie.databio.org"
inputs:
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
      type: array
      items: string
    doc: One or more URLs to add to the genome_servers attribute in config file.
    inputBinding:
      position: 101
      prefix: --genome-server
  - id: reset
    type:
      - 'null'
      - boolean
    doc: Overwrite the current list of server URLs.
    inputBinding:
      position: 101
      prefix: --reset
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
stdout: refgenie_subscribe.out
