cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mavis
  - config
label: mavis_mavis_config
doc: "MAVIS configuration tool (Note: The provided help text contains only system
  error messages regarding container execution and does not list available arguments).\n
  \nTool homepage: https://github.com/bcgsc/mavis.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
stdout: mavis_mavis_config.out
