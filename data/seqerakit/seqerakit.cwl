cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqerakit
label: seqerakit
doc: "Create resources on Seqera Platform using a YAML configuration file.\n\nTool
  homepage: https://github.com/seqeralabs/seqera-kit"
inputs:
  - id: yaml
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more YAML files with Seqera Platform resource definitions.
    inputBinding:
      position: 1
  - id: cli
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional Seqera Platform CLI specific options to be passed, enclosed 
      in double quotes.
    inputBinding:
      position: 102
      prefix: --cli
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Recursively delete resources defined in the YAML files.
    inputBinding:
      position: 102
      prefix: --delete
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Print the commands that would be executed.
    inputBinding:
      position: 102
      prefix: --dryrun
  - id: env_file
    type:
      - 'null'
      - File
    doc: Path to a YAML file containing environment variables for configuration.
    inputBinding:
      position: 102
      prefix: --env-file
  - id: info
    type:
      - 'null'
      - boolean
    doc: Display Seqera Platform information and exit.
    inputBinding:
      position: 102
      prefix: --info
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output JSON format in stdout.
    inputBinding:
      position: 102
      prefix: --json
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (CRITICAL, ERROR, WARNING, INFO, DEBUG).
    inputBinding:
      position: 102
      prefix: --log_level
  - id: on_exists
    type:
      - 'null'
      - string
    doc: Globally specifies the action to take if a resource already exists 
      (fail, ignore, overwrite).
    inputBinding:
      position: 102
      prefix: --on-exists
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Globally enable overwrite for all resources defined in YAML input(s). Deprecated:
      Please use '--on-exists=overwrite' instead."
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: targets
    type:
      - 'null'
      - string
    doc: Specify the resources to be targeted for creation in a YAML file 
      through a comma-separated list.
    inputBinding:
      position: 102
      prefix: --targets
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output for Seqera Platform CLI.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqerakit:0.5.6--pyhdfd78af_0
stdout: seqerakit.out
