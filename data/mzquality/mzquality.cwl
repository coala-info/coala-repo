cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzquality
label: mzquality
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding disk space during a
  container build process.\n\nTool homepage: https://github.com/hankemeierlab/mzQuality"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mzquality:phenomenal-v0.9.5_cv0.9.5.15
stdout: mzquality.out
