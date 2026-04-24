cwlVersion: v1.2
class: CommandLineTool
baseCommand: nebulizer list_tools
label: nebulizer_list_tools
doc: "List information about tools and installed tool repositories.\n\nTool homepage:
  https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_instance
    type: string
    doc: GALAXY instance
    inputBinding:
      position: 1
  - id: built_in
    type:
      - 'null'
      - boolean
    doc: include built-in tools. (NB this option is ignored in 'export' mode.)
    inputBinding:
      position: 102
      prefix: --built-in
  - id: check_toolshed
    type:
      - 'null'
      - boolean
    doc: check installed revisions directly against those available in the 
      toolshed. NB this can be extremely slow.
    inputBinding:
      position: 102
      prefix: --check-toolshed
  - id: mode
    type:
      - 'null'
      - string
    doc: "set reporting mode: either 'repos' (repository-centric view, the default),
      'tools' (tool-centric view) or 'export' (tab-delimited format for use with 'install_tool')."
    inputBinding:
      position: 102
      prefix: --mode
  - id: name
    type:
      - 'null'
      - string
    doc: only list tool repositories matching NAME. Can include glob-style 
      wild-cards.
    inputBinding:
      position: 102
      prefix: --name
  - id: owner
    type:
      - 'null'
      - string
    doc: only list repositories from matching OWNER. Can include glob-style 
      wild-cards.
    inputBinding:
      position: 102
      prefix: --owner
  - id: toolshed
    type:
      - 'null'
      - string
    doc: only list repositories installed from toolshed matching TOOLSHED. Can 
      include glob-style wild-cards.
    inputBinding:
      position: 102
      prefix: --toolshed
  - id: updateable
    type:
      - 'null'
      - boolean
    doc: only show repositories with uninstalled updates or upgrades.
    inputBinding:
      position: 102
      prefix: --updateable
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_tools.out
