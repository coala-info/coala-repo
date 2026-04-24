cwlVersion: v1.2
class: CommandLineTool
baseCommand: ascli
label: aspera-cli_ascli
doc: "Use Aspera application to perform operations on command line.\n\nTool homepage:
  https://github.com/IBM/aspera-cli"
inputs:
  - id: ascp_path
    type:
      - 'null'
      - File
    doc: Path to ascp
    inputBinding:
      position: 101
      prefix: --ascp-path
  - id: ask_options
    type:
      - 'null'
      - string
    doc: 'Ask even optional options: [no], yes'
    inputBinding:
      position: 101
      prefix: --ask-options
  - id: bash_comp
    type:
      - 'null'
      - boolean
    doc: Generate bash completion for command
    inputBinding:
      position: 101
      prefix: --bash-comp
  - id: bfail
    type:
      - 'null'
      - string
    doc: 'Bulk operation error handling: no, [yes]'
    inputBinding:
      position: 101
      prefix: --bfail
  - id: bulk
    type:
      - 'null'
      - string
    doc: 'Bulk operation (only some): [no], yes'
    inputBinding:
      position: 101
      prefix: --bulk
  - id: cache_tokens
    type:
      - 'null'
      - string
    doc: 'Save and reuse OAuth tokens: no, [yes]'
    inputBinding:
      position: 101
      prefix: --cache-tokens
  - id: cert_stores
    type:
      - 'null'
      - type: array
        items: string
    doc: List of folder with trusted certificates (Array, String)
    inputBinding:
      position: 101
      prefix: --cert-stores
  - id: clean_temp
    type:
      - 'null'
      - string
    doc: 'Cleanup temporary files on exit: no, [yes]'
    inputBinding:
      position: 101
      prefix: --clean-temp
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to YAML file with preset configuration
    inputBinding:
      position: 101
      prefix: --config-file
  - id: default
    type:
      - 'null'
      - string
    doc: 'Wizard: set as default configuration for specified plugin (also: update):
      no, [yes]'
    inputBinding:
      position: 101
      prefix: --default
  - id: display
    type:
      - 'null'
      - string
    doc: 'Output only some information: [info], data, error'
    inputBinding:
      position: 101
      prefix: --display
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Comma separated list of: fields, or ALL, or DEF (String, Array, Regexp,
      Proc)'
    inputBinding:
      position: 101
      prefix: --fields
  - id: flat_hash
    type:
      - 'null'
      - string
    doc: '(Table) Display deep values as additional keys: no, [yes]'
    inputBinding:
      position: 101
      prefix: --flat-hash
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: text, nagios, ruby, json, jsonpp, yaml, [table], csv, image'
    inputBinding:
      position: 101
      prefix: --format
  - id: fpac
    type:
      - 'null'
      - string
    doc: Proxy auto configuration script
    inputBinding:
      position: 101
      prefix: --fpac
  - id: home
    type:
      - 'null'
      - string
    doc: Home folder for tool (String)
    inputBinding:
      position: 101
      prefix: --home
  - id: http_options
    type:
      - 'null'
      - string
    doc: Options for HTTP/S socket (Hash)
    inputBinding:
      position: 101
      prefix: --http-options
  - id: http_proxy
    type:
      - 'null'
      - string
    doc: URL for HTTP proxy with optional credentials (String)
    inputBinding:
      position: 101
      prefix: --http-proxy
  - id: ignore_certificate
    type:
      - 'null'
      - type: array
        items: string
    doc: Do not validate HTTPS certificate for these URLs (Array)
    inputBinding:
      position: 101
      prefix: --ignore-certificate
  - id: image
    type:
      - 'null'
      - string
    doc: Options for image display (Hash)
    inputBinding:
      position: 101
      prefix: --image
  - id: insecure
    type:
      - 'null'
      - string
    doc: 'Do not validate any HTTPS certificate: [no], yes'
    inputBinding:
      position: 101
      prefix: --insecure
  - id: interactive
    type:
      - 'null'
      - string
    doc: 'Use interactive input of missing params: [no], yes'
    inputBinding:
      position: 101
      prefix: --interactive
  - id: key_path
    type:
      - 'null'
      - File
    doc: 'Wizard: path to private key for JWT'
    inputBinding:
      position: 101
      prefix: --key-path
  - id: lock_port
    type:
      - 'null'
      - int
    doc: Prevent dual execution of a command, e.g. in cron (Integer)
    inputBinding:
      position: 101
      prefix: --lock-port
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Log level: trace2, trace1, debug, info, [warn], error, fatal, unknown'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: log_secrets
    type:
      - 'null'
      - string
    doc: 'Show passwords in logs: [no], yes'
    inputBinding:
      position: 101
      prefix: --log-secrets
  - id: logger
    type:
      - 'null'
      - string
    doc: 'Logging method: [stderr], stdout, syslog'
    inputBinding:
      position: 101
      prefix: --logger
  - id: multi_table
    type:
      - 'null'
      - string
    doc: '(Table) Each element of a table are displayed as a table: [no], yes'
    inputBinding:
      position: 101
      prefix: --multi-table
  - id: no_default
    type:
      - 'null'
      - boolean
    doc: Do not load default configuration for plugin
    inputBinding:
      position: 101
      prefix: --no-default
  - id: notify_template
    type:
      - 'null'
      - string
    doc: Email ERB template for notification of transfers
    inputBinding:
      position: 101
      prefix: --notify-template
  - id: notify_to
    type:
      - 'null'
      - string
    doc: Email recipient for notification of transfers
    inputBinding:
      position: 101
      prefix: --notify-to
  - id: once_only
    type:
      - 'null'
      - string
    doc: 'Process only new items (some commands): [no], yes'
    inputBinding:
      position: 101
      prefix: --once-only
  - id: override
    type:
      - 'null'
      - string
    doc: 'Wizard: override existing value: [no], yes'
    inputBinding:
      position: 101
      prefix: --override
  - id: pid_file
    type:
      - 'null'
      - string
    doc: Write process identifier to file, delete on exit (String)
    inputBinding:
      position: 101
      prefix: --pid-file
  - id: plugin_folder
    type:
      - 'null'
      - Directory
    doc: Folder where to find additional plugins
    inputBinding:
      position: 101
      prefix: --plugin-folder
  - id: preset
    type:
      - 'null'
      - string
    doc: Load the named option preset from current config file
    inputBinding:
      position: 101
      prefix: --presetVALUE
  - id: progress_bar
    type:
      - 'null'
      - string
    doc: 'Display progress bar: [no], yes'
    inputBinding:
      position: 101
      prefix: --progress-bar
  - id: property
    type:
      - 'null'
      - string
    doc: Name of property to set (modify operation)
    inputBinding:
      position: 101
      prefix: --property
  - id: proxy_credentials
    type:
      - 'null'
      - type: array
        items: string
    doc: 'HTTP proxy credentials for fpac: user, password (Array)'
    inputBinding:
      position: 101
      prefix: --proxy-credentials
  - id: query
    type:
      - 'null'
      - string
    doc: Additional filter for for some commands (list/delete) (Hash, Array)
    inputBinding:
      position: 101
      prefix: --query
  - id: sdk_folder
    type:
      - 'null'
      - Directory
    doc: SDK folder path
    inputBinding:
      position: 101
      prefix: --sdk-folder
  - id: sdk_url
    type:
      - 'null'
      - string
    doc: URL to get SDK
    inputBinding:
      position: 101
      prefix: --sdk-url
  - id: secret
    type:
      - 'null'
      - string
    doc: Secret for access keys
    inputBinding:
      position: 101
      prefix: --secret
  - id: select
    type:
      - 'null'
      - string
    doc: 'Select only some items in lists: column, value (Hash, Proc)'
    inputBinding:
      position: 101
      prefix: --select
  - id: show_config
    type:
      - 'null'
      - boolean
    doc: Display parameters used for the provided action
    inputBinding:
      position: 101
      prefix: --show-config
  - id: show_secrets
    type:
      - 'null'
      - string
    doc: 'Show secrets on command output: [no], yes'
    inputBinding:
      position: 101
      prefix: --show-secrets
  - id: silent_insecure
    type:
      - 'null'
      - string
    doc: 'Issue a warning if certificate is ignored: no, [yes]'
    inputBinding:
      position: 101
      prefix: --silent-insecure
  - id: smtp
    type:
      - 'null'
      - string
    doc: SMTP configuration (Hash)
    inputBinding:
      position: 101
      prefix: --smtp
  - id: sources
    type:
      - 'null'
      - string
    doc: How list of transferred files is provided (@args,@ts,Array)
    inputBinding:
      position: 101
      prefix: --sources
  - id: src_type
    type:
      - 'null'
      - string
    doc: 'Type of file list: [list], pair'
    inputBinding:
      position: 101
      prefix: --src-type
  - id: struct_parser
    type:
      - 'null'
      - string
    doc: 'Default parser when expected value is a struct: json, ruby'
    inputBinding:
      position: 101
      prefix: --struct-parser
  - id: table_style
    type:
      - 'null'
      - string
    doc: Table display style (Hash)
    inputBinding:
      position: 101
      prefix: --table-style
  - id: test_mode
    type:
      - 'null'
      - string
    doc: 'Wizard: skip private key check step: [no], yes'
    inputBinding:
      position: 101
      prefix: --test-mode
  - id: to_folder
    type:
      - 'null'
      - Directory
    doc: Destination folder for transferred files
    inputBinding:
      position: 101
      prefix: --to-folder
  - id: transfer
    type:
      - 'null'
      - string
    doc: 'Type of transfer agent: trsdk, alpha, httpgw, [direct], node, connect'
    inputBinding:
      position: 101
      prefix: --transfer
  - id: transfer_info
    type:
      - 'null'
      - string
    doc: Parameters for transfer agent (Hash)
    inputBinding:
      position: 101
      prefix: --transfer-info
  - id: transpose_single
    type:
      - 'null'
      - string
    doc: '(Table) Single object fields output vertically: no, [yes]'
    inputBinding:
      position: 101
      prefix: --transpose-single
  - id: ts
    type:
      - 'null'
      - string
    doc: Override transfer spec values (Hash)
    inputBinding:
      position: 101
      prefix: --ts
  - id: ui
    type:
      - 'null'
      - string
    doc: 'Method to start browser: [text], graphical'
    inputBinding:
      position: 101
      prefix: --ui
  - id: use_product
    type:
      - 'null'
      - string
    doc: Use ascp from specified product
    inputBinding:
      position: 101
      prefix: --use-product
  - id: vault
    type:
      - 'null'
      - string
    doc: Vault for secrets (Hash)
    inputBinding:
      position: 101
      prefix: --vault
  - id: vault_password
    type:
      - 'null'
      - string
    doc: Vault password
    inputBinding:
      position: 101
      prefix: --vault-password
  - id: version_check_days
    type:
      - 'null'
      - string
    doc: Period in days to check new version (zero to disable)
    inputBinding:
      position: 101
      prefix: --version-check-days
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Destination for results (String)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0
