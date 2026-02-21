cwlVersion: v1.2
class: CommandLineTool
baseCommand: motifscan
label: motifscan
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/shao-lab/MotifScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifscan:1.3.0--py310h1fe012e_5
stdout: motifscan.out
