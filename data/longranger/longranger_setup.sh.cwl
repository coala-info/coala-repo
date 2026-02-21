cwlVersion: v1.2
class: CommandLineTool
baseCommand: longranger_setup.sh
label: longranger_setup.sh
doc: "Setup script for Long Ranger (Note: The provided help text contains only error
  logs and no usage information).\n\nTool homepage: https://github.com/linuz/LongRangeReader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/longranger:v2.2.2_cv2
stdout: longranger_setup.sh.out
