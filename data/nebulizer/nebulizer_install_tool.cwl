cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - install_tool
label: nebulizer_install_tool
doc: "Install tool(s) from toolshed.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy instance to install tool(s) into
    inputBinding:
      position: 1
  - id: repositories
    type:
      type: array
      items: string
    doc: Repository information for the tool(s) to install. Can be a full URL, 
      OWNER/TOOLNAME, or [TOOLSHED] OWNER TOOLNAME [REVISION].
    inputBinding:
      position: 2
  - id: file
    type:
      - 'null'
      - File
    doc: Install tools specified in TSV_FILE.
    inputBinding:
      position: 103
  - id: install_repository_dependencies
    type:
      - 'null'
      - string
    doc: Install repository dependencies via the toolshed, if any are defined.
    default: yes
    inputBinding:
      position: 103
  - id: install_resolver_dependencies
    type:
      - 'null'
      - string
    doc: Install dependencies through a resolver that supports installation 
      (e.g. conda).
    default: yes
    inputBinding:
      position: 103
  - id: install_tool_dependencies
    type:
      - 'null'
      - string
    doc: Install tool dependencies via the toolshed, if any are defined.
    default: yes
    inputBinding:
      position: 103
  - id: no_wait
    type:
      - 'null'
      - boolean
    doc: Don't wait for lengthy tool installations to complete.
    inputBinding:
      position: 103
  - id: timeout
    type:
      - 'null'
      - int
    doc: Wait up to TIMEOUT seconds for tool installations to complete.
    default: 600
    inputBinding:
      position: 103
  - id: tool_panel_section
    type:
      - 'null'
      - string
    doc: Tool panel section name or id to install the tool under; if the section
      doesn't exist then it will be created. If this option is omitted then the 
      tool will be installed at the top-level i.e. not in any section.
    inputBinding:
      position: 103
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Don't ask for confirmation of installation.
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_install_tool.out
