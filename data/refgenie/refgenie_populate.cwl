cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie populate
label: refgenie_populate
doc: "Populate registry paths with local paths.\n\nTool homepage: http://refgenie.databio.org"
inputs:
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
stdout: refgenie_populate.out
