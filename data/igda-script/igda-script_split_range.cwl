cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - split_range
label: igda-script_split_range
doc: "Split a range into segments of about segsize (segsize must be > 2000) and print start/end pairs.\nUsage: split_range start end segsize\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: start
    type: int
    doc: "range start"
    inputBinding:
      position: 1
  - id: end
    type: int
    doc: "range end"
    inputBinding:
      position: 2
  - id: segsize
    type: int
    doc: "segment size (> 2000)"
    inputBinding:
      position: 3
outputs:
  - id: segments
    type: stdout
    doc: "tab-separated start and end of each segment"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: segments.txt
