cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbase
label: rbase
doc: "A containerized R base environment. Note: The provided text appears to be a
  container engine log rather than tool help text.\n\nTool homepage: https://github.com/sgayou/rbasefind"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rbase:phenomenal-v3.4.3-1xenial0_cv0.3.17
stdout: rbase.out
