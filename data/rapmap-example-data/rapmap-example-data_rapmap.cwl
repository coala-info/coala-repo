cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap
label: rapmap-example-data_rapmap
doc: "RapMap is a tool for rapid sensitive mapping of RNA-seq reads. (Note: The provided
  text is a system error log and does not contain specific help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-example-data_rapmap.out
