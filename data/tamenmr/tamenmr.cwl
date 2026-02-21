cwlVersion: v1.2
class: CommandLineTool
baseCommand: tamenmr
label: tamenmr
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tamenmr'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/PGB-LIV/tameNMR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tamenmr:phenomenal-v1.0_cv0.5.10
stdout: tamenmr.out
