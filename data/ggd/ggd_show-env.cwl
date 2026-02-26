cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggd
  - show-env
label: ggd_show-env
doc: "Display the environment variables for data packages installed in the current\n\
  conda environment\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: pattern
    type:
      - 'null'
      - string
    doc: "regular expression pattern to match the name of the\nvariable desired"
    inputBinding:
      position: 101
      prefix: --pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_show-env.out
