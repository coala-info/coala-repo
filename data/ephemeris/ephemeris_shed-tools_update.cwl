cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shed-tools
  - update
label: ephemeris_shed-tools_update
doc: "Updates all tools in a Galaxy server to the latest revision.\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: Where the log file should be stored. Default is a file in the system temp folder
    inputBinding:
      position: 101
      prefix: --log-file
  - id: galaxy
    type:
      - 'null'
      - string
    doc: Target Galaxy instance URL/IP address
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: user
    type:
      - 'null'
      - string
    doc: Galaxy user email address
    inputBinding:
      position: 101
      prefix: --user
  - id: password
    type:
      - 'null'
      - string
    doc: Password for the Galaxy user
    inputBinding:
      position: 101
      prefix: --password
  - id: api_key
    type:
      - 'null'
      - string
    doc: Galaxy admin user API key (required if not defined in the tools list file)
    inputBinding:
      position: 101
      prefix: --api-key
  - id: tools_file
    type:
      - 'null'
      - File
    doc: Tools file to use (see tool_list.yaml.sample)
    inputBinding:
      position: 101
      prefix: --tools-file
  - id: yaml_tool
    type:
      - 'null'
      - string
    doc: Install tool represented by yaml string
    inputBinding:
      position: 101
      prefix: --yaml-tool
  - id: name
    type:
      - 'null'
      - string
    doc: The name of the tool to install (only applicable if the tools file is not provided).
    inputBinding:
      position: 101
      prefix: --name
  - id: owner
    type:
      - 'null'
      - string
    doc: The owner of the tool to install (only applicable if the tools file is not provided).
    inputBinding:
      position: 101
      prefix: --owner
  - id: revisions
    type:
      - 'null'
      - type: array
        items: string
    doc: The revisions of the tool repository that will be installed (only applicable if the tools file is not provided).
    inputBinding:
      position: 101
      prefix: --revisions
  - id: tool_shed_url
    type:
      - 'null'
      - string
    doc: The Tool Shed URL where to install the tool from. Applicable only if the tool info is given as options and not in the tools file.
    inputBinding:
      position: 101
      prefix: --tool-shed
  - id: install_tool_dependencies
    type:
      - 'null'
      - boolean
    doc: Turn on installation of tool dependencies using classic toolshed packages.
    inputBinding:
      position: 101
      prefix: --install-tool-dependencies
  - id: skip_install_resolver_dependencies
    type:
      - 'null'
      - boolean
    doc: Skip installing tool dependencies through resolver (for example conda).
    inputBinding:
      position: 101
      prefix: --skip-install-resolver-dependencies
  - id: skip_install_repository_dependencies
    type:
      - 'null'
      - boolean
    doc: Skip installing the repository dependencies.
    inputBinding:
      position: 101
      prefix: --skip-install-repository-dependencies
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run tool tests on installed tools, requires Galaxy 18.05 or newer.
    inputBinding:
      position: 101
      prefix: --test
  - id: test_existing
    type:
      - 'null'
      - boolean
    doc: If testing tools during install, also run tool tests on repositories already installed.
    inputBinding:
      position: 101
      prefix: --test-existing
  - id: test_json
    type:
      - 'null'
      - string
    doc: Record tool test output to the specified file.
    inputBinding:
      position: 101
      prefix: --test-json
  - id: test_user_api_key
    type:
      - 'null'
      - string
    doc: API key of the user that runs the tests.
    inputBinding:
      position: 101
      prefix: --test-user-api-key
  - id: test_user
    type:
      - 'null'
      - string
    doc: Email of the user that runs the tests (created if needed).
    inputBinding:
      position: 101
      prefix: --test-user
  - id: parallel_tests
    type:
      - 'null'
      - int
    doc: Maximum number of tests that will be run in parallel.
    inputBinding:
      position: 101
      prefix: --parallel-tests
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_shed-tools_update.out
