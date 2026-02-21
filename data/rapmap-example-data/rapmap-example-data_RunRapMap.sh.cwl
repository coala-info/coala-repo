cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapmap-example-data_RunRapMap.sh
label: rapmap-example-data_RunRapMap.sh
doc: "A script to run RapMap with example data. Note: The provided help text contains
  only container execution logs and error messages, and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/COMBINE-lab/RapMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rapmap-example-data:v0.12.0dfsg-3-deb_cv1
stdout: rapmap-example-data_RunRapMap.sh.out
