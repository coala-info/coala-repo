cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenieserver
  - archive
label: refgenieserver_archive
doc: "prepare servable archives\n\nTool homepage: https://refgenie.databio.org/"
inputs:
  - id: asset_registry_paths
    type:
      type: array
      items: string
    doc: One or more registry path strings that identify assets, e.g. 
      hg38/fasta:tag
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: "A path to the refgenie config file (YAML). If not provided, the first available
      environment variable among: 'REFGENIE' will be used if set. Currently: not set"
    inputBinding:
      position: 102
      prefix: --config
  - id: dbg
    type:
      - 'null'
      - boolean
    doc: Set logger verbosity to debug
    inputBinding:
      position: 102
      prefix: --dbg
  - id: force
    type:
      - 'null'
      - boolean
    doc: whether the server file tree should be rebuilt even if exists
    inputBinding:
      position: 102
      prefix: --force
  - id: genomes_desc
    type:
      - 'null'
      - File
    doc: 'Path to a CSV file with genomes descriptions. Format: genome_name, genome
      description'
    inputBinding:
      position: 102
      prefix: --genomes-desc
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove selected genome, genome/asset or genome/asset:tag
    inputBinding:
      position: 102
      prefix: --remove
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
stdout: refgenieserver_archive.out
