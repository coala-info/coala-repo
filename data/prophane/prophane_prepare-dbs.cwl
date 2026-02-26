cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophane
  - prepare-dbs
label: prophane_prepare-dbs
doc: "download the databases required to execute the tasks in the provided CONFIGFILE\n\
  \nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs:
  - id: configfile
    type: File
    doc: Configuration file specifying required databases
    inputBinding:
      position: 1
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to Snakemake
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_prepare-dbs.out
