cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboseed
  - ribo
  - score
label: riboseed_ribo score
doc: "The provided text does not contain help information, but appears to be a system
  error log from a container execution failure.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo score.out
