cwlVersion: v1.2
class: CommandLineTool
baseCommand: shared_samples.py
label: souporcell_shared_samples.py
doc: "determine which clusters are the shared clusters between two souporcell runs with shared samples\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: experiment1
    type: Directory
    doc: "souporcell directory for experiment 1"
    inputBinding:
      position: 11
      prefix: '-1'
  - id: experiment2
    type: Directory
    doc: "souporcell directory for experiment 2"
    inputBinding:
      position: 11
      prefix: '-2'
  - id: shared
    type: int
    doc: "how many samples should these experiments share?"
    inputBinding:
      position: 11
      prefix: -n
outputs:
  - id: shared_clusters
    type: stdout
    doc: Shared clusters between the two runs (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
stdout: souporcell_shared_samples.out
