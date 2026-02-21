cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboseed
  - ribo
  - sketch
label: riboseed_ribo sketch
doc: "A component of the riboSeed pipeline (Note: The provided help text contained
  only system error logs and no usage information; arguments could not be extracted).\n
  \nTool homepage: https://github.com/nickp60/riboSeed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo sketch.out
