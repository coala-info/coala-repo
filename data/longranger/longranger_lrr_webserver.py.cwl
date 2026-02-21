cwlVersion: v1.2
class: CommandLineTool
baseCommand: longranger_lrr_webserver.py
label: longranger_lrr_webserver.py
doc: "Long Ranger LRR web server\n\nTool homepage: https://github.com/linuz/LongRangeReader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/longranger:v2.2.2_cv2
stdout: longranger_lrr_webserver.py.out
