cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vispr
  - config
label: vispr_config
doc: "Print an example VISPR config. Save this config to a file and edit according
  to your needs.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Example VISPR config (YAML)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_config.yaml
