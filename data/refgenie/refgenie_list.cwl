cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie list
label: refgenie_list
doc: "List available local assets.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: genome
    type:
      - 'null'
      - type: array
        items: string
    doc: Reference assembly ID, e.g. mm10.
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 101
      prefix: --genome-config
  - id: recipes
    type:
      - 'null'
      - boolean
    doc: List available recipes.
    inputBinding:
      position: 101
      prefix: --recipes
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
stdout: refgenie_list.out
