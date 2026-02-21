cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboseed
  - ribo
  - snag
label: riboseed_ribo snag
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/nickp60/riboSeed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo snag.out
