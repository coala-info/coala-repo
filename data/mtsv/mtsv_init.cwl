cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtsv
  - init
label: mtsv_init
doc: "Initializes a directory with a pre-filled parameters file\n\nTool homepage: https://github.com/FofanovLab/MTSv"
inputs:
  - id: config
    type: string
    default: mtsv.cfg
    doc: "Specify path to write config file, not required if using default config (default: ./mtsv.cfg)"
    inputBinding:
      prefix: --config
  - id: working_dir
    type: string
    default: .
    doc: "Specify working directory to place output (default: /tmp)"
    inputBinding:
      prefix: --working_dir
outputs:
  - id: config_file
    type: File
    doc: Pre-filled mtsv parameters file
    outputBinding:
      glob: $(inputs.config)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
