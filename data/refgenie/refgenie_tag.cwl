cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie tag
label: refgenie_tag
doc: "Tag an asset.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: asset_registry_paths
    type:
      type: array
      items: string
    doc: One or more registry path strings that identify assets (e.g. hg38/fasta
      or hg38/fasta:tag).
    inputBinding:
      position: 1
  - id: default
    type:
      - 'null'
      - boolean
    doc: Set the selected asset tag as the default one.
    inputBinding:
      position: 102
      prefix: --default
  - id: force
    type:
      - 'null'
      - boolean
    doc: Do not prompt before action, approve upfront.
    inputBinding:
      position: 102
      prefix: --force
  - id: genome
    type:
      - 'null'
      - string
    doc: Reference assembly ID, e.g. mm10.
    inputBinding:
      position: 102
      prefix: --genome
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 102
      prefix: --genome-config
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 102
      prefix: --skip-read-lock
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag to assign to an asset.
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_tag.out
