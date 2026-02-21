cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap
label: rapmap
doc: "A rapid, sensitive and accurate tool for mapping RNA-seq reads to transcriptomes.\n
  \nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
stdout: rapmap.out
