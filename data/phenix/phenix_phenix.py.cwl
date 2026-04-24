cwlVersion: v1.2
class: CommandLineTool
baseCommand: phenix.py
label: phenix_phenix.py
doc: "A tool for various VCF and reference manipulation tasks.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run.
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand.
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'More verbose logging (default: turned off).'
    inputBinding:
      position: 103
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
stdout: phenix_phenix.py.out
