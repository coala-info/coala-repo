cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap-example-data
label: rapmap-example-data
doc: "Example data for RapMap. Note: The provided text is a container build error
  log and does not contain usage information or argument definitions.\n\nTool homepage:
  https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-example-data.out
