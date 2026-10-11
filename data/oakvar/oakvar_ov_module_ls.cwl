cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - module
  - ls
label: oakvar_ov_module_ls
doc: "Lists OakVar modules.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: module_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Regular expression for module names.
    inputBinding:
      position: 1
  - id: search_store
    type:
      - 'null'
      - boolean
    doc: Include available modules.
    inputBinding:
      position: 102
      prefix: --search-store
  - id: module_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Only list modules of certain types.
    inputBinding:
      position: 102
      prefix: --module-types
  - id: include_hidden
    type:
      - 'null'
      - boolean
    doc: Include hidden modules.
    inputBinding:
      position: 102
      prefix: --include-hidden
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: Only list modules of given tag(s).
    inputBinding:
      position: 102
      prefix: --tags
  - id: nameonly
    type:
      - 'null'
      - boolean
    doc: Only list module names.
    inputBinding:
      position: 102
      prefix: --nameonly
  - id: humanized_size
    type:
      - 'null'
      - boolean
    doc: Machine readable data sizes.
    inputBinding:
      position: 102
      prefix: --humanized-size
  - id: fmt
    type:
      - 'null'
      - string
    doc: Output format. tabular or json.
    inputBinding:
      position: 102
      prefix: --fmt
outputs:
  - id: stdout
    type: stdout
    doc: Module list, printed to standard output.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov_module_ls.out
