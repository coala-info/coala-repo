cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - check_dependencies
label: mdmcleaner_check_dependencies
doc: "Checks if all required dependencies for MDMcleaner are met.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: local config file with basic settings (such as the location of database-files); default looks for mdmcleaner.config in the current working directory
    inputBinding:
      position: 101
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error, where mdmcleaner prints its report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_check_dependencies.out
stderr: mdmcleaner_check_dependencies.err
