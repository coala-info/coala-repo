cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpsw_run
label: gpsw_run
doc: "Run the GPSW pipeline and create report.\n\nTool homepage: https://github.com/niekwit/gps-orfeome"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry-run workflow only
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: profile
    type:
      - 'null'
      - string
    doc: Path to Snakemake profile YAML file (only has to be provided at first 
      run) (OPTIONAL, use value None for no profile)
    inputBinding:
      position: 101
      prefix: --profile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run GPSW quietly
    inputBinding:
      position: 101
      prefix: --quiet
  - id: snakemake_args
    type:
      - 'null'
      - string
    doc: Extra Snakemake arguments (should be '"double-quoted"')
    inputBinding:
      position: 101
      prefix: --snakemake-args
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
stdout: gpsw_run.out
