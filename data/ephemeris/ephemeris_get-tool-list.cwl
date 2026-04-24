cwlVersion: v1.2
class: CommandLineTool
baseCommand: get-tool-list
label: ephemeris_get-tool-list
doc: "Generates a tool_list.yml file for Galaxy.\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: Galaxy admin user API key (required if not defined in the tools list 
      file)
    inputBinding:
      position: 101
      prefix: --api-key
  - id: galaxy
    type:
      - 'null'
      - string
    doc: Target Galaxy instance URL/IP address
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: get_all_tools
    type:
      - 'null'
      - boolean
    doc: Get all tools and revisions, not just those which are present on the 
      web ui.Requires login details.
    inputBinding:
      position: 101
      prefix: --get-all-tools
  - id: get_data_managers
    type:
      - 'null'
      - boolean
    doc: Include the data managers in the tool list. Requires admin login 
      details
    inputBinding:
      position: 101
      prefix: --get-data-managers
  - id: include_tool_panel_id
    type:
      - 'null'
      - boolean
    doc: Include tool_panel_id in tool_list.yml ? Use this only if the tool 
      panel id already exists. See 
      https://github.com/galaxyproject/ansible-galaxy-tools/blob/master/files/tool_list.yaml.sample
    inputBinding:
      position: 101
      prefix: --include-tool-panel-id
  - id: output_file
    type: File
    doc: tool_list.yml output file
    inputBinding:
      position: 101
      prefix: --output-file
  - id: password
    type:
      - 'null'
      - string
    doc: Password for the Galaxy user
    inputBinding:
      position: 101
      prefix: --password
  - id: skip_changeset_revision
    type:
      - 'null'
      - boolean
    doc: Do not include the changeset revision when generating the tool list.Use
      this if you would like to use the list to update all the tools inyour 
      galaxy instance using shed-install.
    inputBinding:
      position: 101
      prefix: --skip-changeset-revision
  - id: skip_tool_panel_name
    type:
      - 'null'
      - boolean
    doc: Do not include tool_panel_name in tool_list.yml ?
    inputBinding:
      position: 101
      prefix: --skip-tool-panel-name
  - id: user
    type:
      - 'null'
      - string
    doc: Galaxy user email address
    inputBinding:
      position: 101
      prefix: --user
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_get-tool-list.out
