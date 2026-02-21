cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbasefind
label: rbase_rbasefind
doc: "The provided text is a container runtime error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/sgayou/rbasefind"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rbase:phenomenal-v3.4.3-1xenial0_cv0.3.17
stdout: rbase_rbasefind.out
