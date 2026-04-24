cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcloud
label: google-cloud-sdk_gcloud
doc: "manage Google Cloud Platform resources and developer workflow\n\nTool homepage:
  https://cloud.google.com/sdk/"
inputs:
  - id: account
    type:
      - 'null'
      - string
    doc: Google Cloud Platform user account to use for invocation. Overrides the
      default core/account property value for this command invocation.
    inputBinding:
      position: 101
      prefix: --account
  - id: configuration
    type:
      - 'null'
      - string
    doc: 'The configuration to use for this command invocation. For more information
      on how to use configurations, run: gcloud topic configurations. You can also
      use the [CLOUDSDK_ACTIVE_CONFIG_NAME] environment variable to set the equivalent
      of this flag for a terminal session.'
    inputBinding:
      position: 101
      prefix: --configuration
  - id: flatten
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Flatten name[] output resource slices in KEY into separate records for each
      item in each slice. Multiple keys and slices may be specified. This also flattens
      keys for --format and --filter. For example, --flatten=abc.def[] flattens abc.def[].ghi
      references to abc.def.ghi. A resource record containing abc.def[] with N elements
      will expand to N records in the flattened output. This flag interacts with other
      flags that are applied in this order: --flatten, --sort-by, --filter, --limit.'
    inputBinding:
      position: 101
      prefix: --flatten
  - id: format
    type:
      - 'null'
      - string
    doc: 'Sets the format for printing command output resources. The default is a
      command-specific human-friendly output format. The supported formats are: config,
      csv, default, diff, disable, flattened, get, json, list, multi, none, object,
      table, text, value, yaml. For more details run $ gcloud topic formats.'
    inputBinding:
      position: 101
      prefix: --format
  - id: log_http
    type:
      - 'null'
      - boolean
    doc: Log all HTTP server requests and responses to stderr. Overrides the 
      default core/log_http property value for this command invocation.
    inputBinding:
      position: 101
      prefix: --log-http
  - id: no_user_output_enabled
    type:
      - 'null'
      - boolean
    doc: Disable user intended output to the console. Overrides the default 
      core/user_output_enabled property value for this command invocation.
    inputBinding:
      position: 101
      prefix: --no-user-output-enabled
  - id: project
    type:
      - 'null'
      - string
    doc: The Google Cloud Platform project name to use for this invocation. If 
      omitted then the current project is assumed. Overrides the default 
      core/project property value for this command invocation.
    inputBinding:
      position: 101
      prefix: --project
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable all interactive prompts when running gcloud commands. If input 
      is required, defaults will be used, or an error will be raised. Overrides 
      the default core/disable_prompts property value for this command 
      invocation. Must be used at the beginning of commands. This is equivalent 
      to setting the environment variable CLOUDSDK_CORE_DISABLE_PROMPTS to 1.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: trace_token
    type:
      - 'null'
      - string
    doc: Token used to route traces of service requests for investigation of 
      issues. Overrides the default core/trace_token property value for this 
      command invocation.
    inputBinding:
      position: 101
      prefix: --trace-token
  - id: user_output_enabled
    type:
      - 'null'
      - boolean
    doc: Print user intended output to the console. Overrides the default 
      core/user_output_enabled property value for this command invocation. Use 
      --no-user-output-enabled to disable.
    inputBinding:
      position: 101
      prefix: --user-output-enabled
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Override the default verbosity for this command. VERBOSITY must be one of:
      debug, info, warning, error, critical, none.'
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gcloud.out
