cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - align
label: sga_sga-align
doc: "The provided text does not contain help information for sga-align; it contains
  a system error log regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/jts/sga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_sga-align.out
