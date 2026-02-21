cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecomet_i2c_ecomet_detect.py
label: ecomet_i2c_ecomet_detect.py
doc: "A tool for ecomet detection. (Note: The provided help text contains only system
  error logs and no usage information; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/mamin27/ecomet_i2c_raspberry_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ecomet:phenomenal-v1.1_cv0.3.39
stdout: ecomet_i2c_ecomet_detect.py.out
