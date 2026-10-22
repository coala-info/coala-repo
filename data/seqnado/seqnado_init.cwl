cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqnado
  - init
label: seqnado_init
doc: "Initialize SeqNado user environment. Copies Snakemake profiles and creates the
  genome config file (~/.config/seqnado/genome_config.json).\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: preset
    type:
      - 'null'
      - boolean
    doc: Use packaged preset genomes instead of the editable template
    inputBinding:
      position: 1
      prefix: --preset
  - id: no_preset
    type:
      - 'null'
      - boolean
    doc: Use the editable template (default)
    inputBinding:
      position: 1
      prefix: --no-preset
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show actions without executing them
    inputBinding:
      position: 1
      prefix: --dry-run
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: genome_config
    type:
      - 'null'
      - File
    doc: Genome configuration file created in the home directory
    outputBinding:
      glob: .config/seqnado/genome_config.json
  - id: snakemake_profiles
    type:
      - 'null'
      - Directory
    doc: Snakemake profiles copied to the home directory
    outputBinding:
      glob: .config/snakemake
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_init.out
