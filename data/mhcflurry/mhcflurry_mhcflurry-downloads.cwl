cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-downloads
label: mhcflurry_mhcflurry-downloads
doc: "Download MHCflurry released datasets and trained models.\n\nTool homepage: https://github.com/hammerlab/mhcflurry"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute (fetch, info, path, url)
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output less
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output more
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
stdout: mhcflurry_mhcflurry-downloads.out
