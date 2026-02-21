cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap
label: rapmap-dev
doc: "RapMap is a rapid, sensitive and accurate tool for mapping RNA-seq reads. (Note:
  The provided text is a container build error log and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-dev:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-dev.out
