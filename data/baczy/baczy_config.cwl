cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - baczy
  - config
label: baczy_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/npbhavya/baczy/"
inputs:
  - id: configfile
    type:
      - 'null'
      - string
    doc: Copy template config to file
    default: config.yaml
    inputBinding:
      position: 101
      prefix: --configfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baczy:1.0.3--pyhdfd78af_0
stdout: baczy_config.out
