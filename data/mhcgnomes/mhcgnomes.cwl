cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcgnomes
label: mhcgnomes
doc: "Parse MHC strings and print a table with parsed properties.\n\nTool homepage:
  https://github.com/til-unc/mhcgnomes"
inputs:
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: MHC names to parse. If omitted, non-empty lines are read from stdin.
    inputBinding:
      position: 1
  - id: default_species
    type:
      - 'null'
      - string
    doc: Default species prefix used when the input is missing one
    inputBinding:
      position: 102
      prefix: --default-species
  - id: format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 102
      prefix: --format
  - id: infer_class2_pairing
    type:
      - 'null'
      - boolean
    doc: Infer canonical Class II alpha chain when only beta chain is given.
    inputBinding:
      position: 102
      prefix: --infer-class2-pairing
  - id: max_allele_fields
    type:
      - 'null'
      - int
    doc: If set, restrict parsed alleles to this many fields.
    inputBinding:
      position: 102
      prefix: --max-allele-fields
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Omit header row in table/tsv output.
    inputBinding:
      position: 102
      prefix: --no-header
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Exit with code 1 on the first parse error.
    inputBinding:
      position: 102
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcgnomes:2.0.2--pyh106432d_0
stdout: mhcgnomes.out
