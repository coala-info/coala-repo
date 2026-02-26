cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophane
  - run
label: prophane_run
doc: "execute prophane workflow (using snakemake underneath)\n\nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs:
  - id: configfile
    type: File
    doc: Configuration file for the workflow
    inputBinding:
      position: 1
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to snakemake
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
stdout: prophane_run.out
