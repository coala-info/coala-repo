cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - show_configs
label: mdmcleaner_show_configs
doc: "Shows the current MDMcleaner settings.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: local config file (default searches for a config file in the current working directory)
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
stdout: mdmcleaner_show_configs.out
stderr: mdmcleaner_show_configs.err
