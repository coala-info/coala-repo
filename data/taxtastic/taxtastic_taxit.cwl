cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxit
label: taxtastic_taxit
doc: "Creation, validation, and modification of reference packages for use with `pplacer`
  and related software.\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: action
    type: string
    doc: 'The action to perform. Available actions: help, add_nodes, add_to_taxtable,
      check, composition, create, extract_nodes, findcompany, get_descendants, get_lineage,
      info, lineage_table, lonelynodes, named, namelookup, new_database, refpkg_intersection,
      reroot, rollback, rollforward, rp, strip, taxids, taxtable, update, update_taxids'
    inputBinding:
      position: 1
  - id: action_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified action
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity of screen output (eg, -v is verbose, -vv more so)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit.out
