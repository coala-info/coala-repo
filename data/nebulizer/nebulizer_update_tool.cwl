cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - update_tool
label: nebulizer_update_tool
doc: "Update tool installed from toolshed.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY instance to update tool into
    inputBinding:
      position: 1
  - id: repositories
    type:
      type: array
      items: string
    doc: Repository to update tool from (full URL, OWNER/TOOLNAME, or [TOOLSHED]
      OWNER TOOLNAME)
    inputBinding:
      position: 2
  - id: check_toolshed
    type:
      - 'null'
      - boolean
    doc: check installed revisions directly against those available in the 
      toolshed.
    inputBinding:
      position: 103
      prefix: --check-toolshed
  - id: install_repository_dependencies
    type:
      - 'null'
      - string
    doc: install repository dependencies via the toolshed, if any are defined
    inputBinding:
      position: 103
      prefix: --install-repository-dependencies
  - id: install_resolver_dependencies
    type:
      - 'null'
      - string
    doc: install dependencies through a resolver that supports installation 
      (e.g. conda)
    inputBinding:
      position: 103
      prefix: --install-resolver-dependencies
  - id: install_tool_dependencies
    type:
      - 'null'
      - string
    doc: install tool dependencies via the toolshed, if any are defined
    inputBinding:
      position: 103
      prefix: --install-tool-dependencies
  - id: no_wait
    type:
      - 'null'
      - boolean
    doc: don't wait for lengthy tool installations to complete.
    inputBinding:
      position: 103
      prefix: --no-wait
  - id: timeout
    type:
      - 'null'
      - int
    doc: wait up to TIMEOUT seconds for tool installations to complete
    inputBinding:
      position: 103
      prefix: --timeout
  - id: yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of updates.
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
stdout: nebulizer_update_tool.out
