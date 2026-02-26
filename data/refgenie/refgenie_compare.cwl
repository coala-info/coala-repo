cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie compare
label: refgenie_compare
doc: "Compare two genomes.\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: genome1
    type: string
    doc: First genome for compatibility check.
    inputBinding:
      position: 1
  - id: genome2
    type: string
    doc: Second genome for compatibility check.
    inputBinding:
      position: 2
  - id: flag_meanings
    type:
      - 'null'
      - boolean
    doc: Display compatibility flag meanings.
    inputBinding:
      position: 103
      prefix: --flag-meanings
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Path to local genome configuration file. Optional if REFGENIE 
      environment variable is set.
    inputBinding:
      position: 103
      prefix: --genome-config
  - id: no_explanation
    type:
      - 'null'
      - boolean
    doc: Do not print compatibility code explanation.
    inputBinding:
      position: 103
      prefix: --no-explanation
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 103
      prefix: --skip-read-lock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_compare.out
