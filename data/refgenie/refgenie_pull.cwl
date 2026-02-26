cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie pull
label: refgenie_pull
doc: "Download assets.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: asset_registry_paths
    type:
      type: array
      items: string
    doc: One or more registry path strings that identify assets (e.g. hg38/fasta
      or hg38/fasta:tag).
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - boolean
    doc: 'Use batch mode: pull large archives, do no overwrite'
    inputBinding:
      position: 102
      prefix: --batch
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite if asset exists.
    inputBinding:
      position: 102
      prefix: --force-overwrite
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
  - id: no_large
    type:
      - 'null'
      - boolean
    doc: Do not pull archives over 5GB.
    inputBinding:
      position: 102
      prefix: --no-large
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Do not overwrite if asset exists.
    inputBinding:
      position: 102
      prefix: --no-overwrite
  - id: pull_large
    type:
      - 'null'
      - boolean
    doc: Pull any archive, regardless of its size.
    inputBinding:
      position: 102
      prefix: --pull-large
  - id: size_cutoff
    type:
      - 'null'
      - float
    doc: 'Maximum archive file size to download with no confirmation required (in
      GB, default: 10)'
    default: 10
    inputBinding:
      position: 102
      prefix: --size-cutoff
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 102
      prefix: --skip-read-lock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_pull.out
