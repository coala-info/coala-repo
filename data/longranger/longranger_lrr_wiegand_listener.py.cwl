cwlVersion: v1.2
class: CommandLineTool
baseCommand: longranger_lrr_wiegand_listener.py
label: longranger_lrr_wiegand_listener.py
doc: "A tool within the Long Ranger suite, likely related to LRR (Long Ranger Runtime)
  and Wiegand listener functionality. Note: The provided help text contains only container
  runtime error messages and no usage information.\n\nTool homepage: https://github.com/linuz/LongRangeReader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/longranger:v2.2.2_cv2
stdout: longranger_lrr_wiegand_listener.py.out
