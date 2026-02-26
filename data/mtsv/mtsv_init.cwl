cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv init
label: mtsv_init
doc: "Initialize mtsv project\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Specify path to write config file, not required if using default config
    default: ./mtsv.cfg
    inputBinding:
      position: 101
      prefix: --config
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory to place output.
    default: /
    inputBinding:
      position: 101
      prefix: --working_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
stdout: mtsv_init.out
