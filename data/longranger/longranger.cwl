cwlVersion: v1.2
class: CommandLineTool
baseCommand: longranger
label: longranger
doc: "Long Ranger is a set of analysis pipelines that processes Chromium sequencing
  data to align reads and call and phase SNPs, indels, and structural variants.\n\n
  Tool homepage: https://github.com/linuz/LongRangeReader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/longranger:v2.2.2_cv2
stdout: longranger.out
