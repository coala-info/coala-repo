cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie seek
label: refgenie_seek
doc: "Get the path to a local asset.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: asset_registry_paths
    type:
      type: array
      items: string
    doc: One or more registry path strings that identify assets (e.g. hg38/fasta
      or hg38/fasta:tag or hg38/fasta.fai:tag).
    inputBinding:
      position: 1
  - id: check_exists
    type:
      - 'null'
      - boolean
    doc: Whether the returned asset path should be checked for existence on 
      disk.
    inputBinding:
      position: 102
      prefix: --check-exists
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_seek.out
