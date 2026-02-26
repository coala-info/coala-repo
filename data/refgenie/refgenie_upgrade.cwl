cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie upgrade
label: refgenie_upgrade
doc: "Upgrade config. This will alter the files on disk.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Do not prompt before action, approve upfront.
    inputBinding:
      position: 101
      prefix: --force
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
  - id: target_version
    type: string
    doc: Target config version for the upgrade.
    inputBinding:
      position: 101
      prefix: --target-version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_upgrade.out
