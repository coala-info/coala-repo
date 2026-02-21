cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia
label: python3-mia
doc: "Medical Image Analysis (MIA) software suite for gray scale image processing.\n
  \nTool homepage: https://github.com/Mia-Y1118/python3_webApp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-mia:v0.1.9-1-deb_cv1
stdout: python3-mia.out
