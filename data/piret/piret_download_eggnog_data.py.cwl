cwlVersion: v1.2
class: CommandLineTool
baseCommand: piret_download_eggnog_data.py
label: piret_download_eggnog_data.py
doc: "Download EggNOG data for the PiRET pipeline. (Note: The provided help text contains
  system error logs and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/mshakya/PyPiReT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piret:0.3.4--r44hdfd78af_3
stdout: piret_download_eggnog_data.py.out
