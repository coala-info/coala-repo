cwlVersion: v1.2
class: CommandLineTool
baseCommand: terminus
label: terminus
doc: "The provided text does not contain help information or usage instructions for
  the tool 'terminus'. It appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/COMBINE-lab/terminus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terminus:v0.1.0--h2db0a6b_0
stdout: terminus.out
