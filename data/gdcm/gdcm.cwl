cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdcm
label: gdcm
doc: "No description available: The provided text contains container build errors
  rather than tool help text.\n\nTool homepage: https://github.com/malaterre/GDCM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gdcm:v2.8.8-9-deb-py3_cv1
stdout: gdcm.out
